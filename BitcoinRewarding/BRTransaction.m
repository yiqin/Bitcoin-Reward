//
//  BRTransaction.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRTransaction.h"
#import "BRCoinbase.h"

@implementation BRTransaction

+ (BRTransaction *)parseTransaction:(id)JSON forAccount:(BRAccount*)account {
    BRTransaction *transaction = [[BRTransaction alloc] init];
    NSMutableDictionary *tDict = [JSON objectForKey:@"transaction"];
    transaction.amount = [[tDict objectForKey:@"amount"] objectForKey:@"amount"];
    transaction.sender = [[[tDict objectForKey:@"sender"] objectForKey:@"email"] isEqualToString:account.email];
    transaction.name = transaction.sender ? [[tDict objectForKey:@"recipient"] objectForKey:@"name"] : [[tDict objectForKey:@"sender"] objectForKey:@"name"];
    if (!([tDict objectForKey:@"hsh"] == [NSNull null])) {
        transaction.hash = [tDict objectForKey:@"hsh"];
    }
    transaction.email = transaction.sender ? [[tDict objectForKey:@"recipient"] objectForKey:@"email"] : [[tDict objectForKey:@"sender"] objectForKey:@"email"];
    if (!transaction.name) {
        transaction.name = [tDict objectForKey:@"recipient_address"];
    }
    transaction.transactionId = [tDict objectForKey:@"id"];
    transaction.timestamp = [tDict objectForKey:@"created_at"];
    transaction.request = [[tDict objectForKey:@"request"] boolValue];
    return transaction;
}

+ (void)send:(NSNumber*)amount to:(NSString*)address withNotes:(NSString*)notes withHandler:(TransactionHandler)handler {
    [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
                NSDictionary *params = @{@"transaction" : @{
                                                 @"to": address,
                                                 @"amount": amount,
                                                 @"notes": notes
                                                 }};
                
                YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
                manager.requestSerializer = [YQJSONRequestSerializer serializer];
                manager.responseSerializer = [YQJSONResponseSerializer serializer];
                [manager POST:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions/send_money?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:params success:^(YQHTTPRequestOperation *operation, id JSON) {
                    handler([self parseTransaction:JSON forAccount:account], nil);
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    handler(nil, error);
                }];
            }];
        }
    }];
}

+ (void)request:(NSNumber*)amount from:(NSString*)address withNotes:(NSString*)notes withHandler:(TransactionHandler)handler {
    [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
                NSDictionary *params = @{@"transaction" : @{
                                                 @"from": address,
                                                 @"amount": amount,
                                                 @"notes": notes
                                                 }};

                YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
                manager.requestSerializer = [YQJSONRequestSerializer serializer];
                manager.responseSerializer = [YQJSONResponseSerializer serializer];
                [manager POST:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions/request_money?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:params success:^(YQHTTPRequestOperation *operation, id JSON) {
                    
                    handler([self parseTransaction:JSON forAccount:account], nil);
   
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    handler(nil, error);
                }];
            }];
        }
    }];
}

+ (void)resend:(NSString*)requestId withHandler:(RequestActionHandler)handler {
    [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
        if (error) {
            handler(NO, error);
        } else {
            [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
                YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
                manager.requestSerializer = [YQJSONRequestSerializer serializer];
                manager.responseSerializer = [YQJSONResponseSerializer serializer];
                [manager PUT:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions/%@/resend_request?access_token=%@", requestId, [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                    
                    handler([[JSON objectForKey:@"success"] boolValue], nil);
                    
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    handler(NO, error);
                }];
            }];
        }
    }];
}

+ (void)cancel:(NSString*)requestId withHandler:(RequestActionHandler)handler {
    [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
        if (error) {
            handler(NO, error);
        } else {
            [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
                YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
                manager.requestSerializer = [YQJSONRequestSerializer serializer];
                manager.responseSerializer = [YQJSONResponseSerializer serializer];
                [manager DELETE:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions/%@/cancel_request?access_token=%@", requestId, [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                    
                    handler([[JSON objectForKey:@"success"] boolValue], nil);
                    
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    handler(NO, error);
                }];
            }];
        }
    }];
}

+ (void)complete:(NSString*)requestId withHandler:(TransactionHandler)handler {
    [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
                YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
                manager.requestSerializer = [YQJSONRequestSerializer serializer];
                manager.responseSerializer = [YQJSONResponseSerializer serializer];
                [manager PUT:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions/%@/complete_request?access_token=%@", requestId, [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                    
                    handler([self parseTransaction:JSON forAccount:account], nil);
                    
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    handler(nil, error);
                }];
            }];
        }
    }];
}

@end
