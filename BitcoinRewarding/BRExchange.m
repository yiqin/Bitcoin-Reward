//
//  BRExchange.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRExchange.h"

@implementation BRExchange
+ (void)getTransfers:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager GET:[NSString stringWithFormat:@"https://coinbase.com/api/v1/transfers?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                return handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                return handler(nil, error);
            }];
        }
    }];
}

+ (void)getBuyPrice:(NSNumber*)qty withHandler:(PriceHandler)handler {
    [BRRequest getRequest:@"https://coinbase.com/api/v1/prices/buy" withHandler:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            handler([[result objectForKey:@"total"] objectForKey:@"amount"], nil);
        }
    }];
}

+ (void)getSellPrice:(NSNumber*)qty withHandler:(PriceHandler)handler {
    [BRRequest getRequest:@"https://coinbase.com/api/v1/prices/sell" withHandler:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            handler([[result objectForKey:@"total"] objectForKey:@"amount"], nil);
        }
    }];
}

+ (void)getSpotRate:(NSString *)currency withHandler:(PriceHandler)handler {
    [BRRequest getRequest:[NSString stringWithFormat:@"https://coinbase.com/api/v1/prices/spot_rate?currency=%@",currency] withHandler:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            handler([result objectForKey:@"amount"], nil);
        }
    }];
}

+ (void)sellBitcoin:(NSNumber *)qty withHandler:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            NSDictionary *params = @{@"qty" : qty};

            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager POST:[NSString stringWithFormat:@"https://coinbase.com/api/v1/sells?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:params success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

+ (void)buyBitcoin:(NSNumber *)qty withHandler:(BRResponseHandler)handler {
    [BRRequest authorizedRequest:^(NSDictionary *result, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            NSDictionary *params = @{@"qty" : qty};
            
            YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
            manager.requestSerializer = [YQJSONRequestSerializer serializer];
            manager.responseSerializer = [YQJSONResponseSerializer serializer];
            [manager POST:[NSString stringWithFormat:@"https://coinbase.com/api/v1/buys?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]] parameters:params success:^(YQHTTPRequestOperation *operation, id JSON) {
                
                handler(JSON, nil);
                
            } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                handler(nil, error);
            }];
        }
    }];
}

+ (void)getExchangeRates:(BRResponseHandler)handler {
    [BRRequest getRequest:@"https://coinbase.com/api/v1/currencies/exchange_rates" withHandler:^(NSDictionary *result, NSError *error) {
        handler(result, error);
    }];
}

+ (void)getSupportedCurrencies:(CurrenciesHandler)handler {
    [BRRequest getRequest:@"https://coinbase.com/api/v1/currencies" withHandler:^(id result, NSError *error) {
        handler(result, error);
    }];
}

@end
