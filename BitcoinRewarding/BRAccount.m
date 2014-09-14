//
//  BRAccount.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRAccount.h"

@implementation BRAccount

- (void)getTransactions:(TransactionsHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transactions?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                NSMutableArray *transactions = [[NSMutableArray alloc] init];
                NSArray *array = [JSON objectForKey:@"transactions"];
                for (NSDictionary *dict in array) {
                    NSDictionary *tDict = [dict objectForKey:@"transaction"];
                    BRTransaction *transaction = [[BRTransaction alloc] init];
                    transaction.amount = [[tDict objectForKey:@"amount"] objectForKey:@"amount"];
                    transaction.sender = [[[tDict objectForKey:@"sender"] objectForKey:@"email"] isEqualToString:self.email];
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
                    [transactions addObject:transaction];
                }
                
                handler(transactions, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

- (void)getAccountChanges:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/account_changes?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

- (void)getCurrentBalance:(BalanceHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/account/balance?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler([JSON objectForKey:@"amount"], nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

- (void)getReceiveAddress:(AddressHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/account/receive_address?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler([JSON objectForKey:@"address"], nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

- (void)getAddresses:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/addresses?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

- (void)getContacts:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/contacts?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

@end
