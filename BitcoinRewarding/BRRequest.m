//
//  BRRequest.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRRequest.h"
#import "BRCoinbase.h"

@implementation BRRequest
+ (void)authorizedRequest:(BRResponseHandler)handler {
    double currentTime = [[NSDate date] timeIntervalSince1970];
    double expiryTime = [[[NSUserDefaults standardUserDefaults] objectForKey:@"expiryTime"] doubleValue];
    if (currentTime >= expiryTime) {
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"refreshToken"];
        
        YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
        manager.responseSerializer = [YQJSONResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:@"https://coinbase.com/oauth/token?grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@", refreshToken, [BRCoinbase getClientId], [BRCoinbase getClientSecret]] parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
            NSLog(@"%@", JSON);

            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] setObject:[JSON objectForKey:@"access_token"] forKey:@"accessToken"];
                [[NSUserDefaults standardUserDefaults] setObject:[JSON objectForKey:@"refresh_token"] forKey:@"refreshToken"];
                double expiryTime = [[NSDate date] timeIntervalSince1970] + 7200;
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:expiryTime] forKey:@"expiryTime"];

                handler(JSON, nil);
            });
            
        } failure:nil];
        
    } else {
        handler(nil, nil); // already authorized
    }
}

+ (void)getRequest:(NSString *)url withHandler:(BRResponseHandler)handler {
    YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
    manager.responseSerializer = [YQJSONResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(YQHTTPRequestOperation *operation, id JSON) {
        handler(JSON, nil);
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        handler(nil, error);
    }];
}
@end
