//
//  Coinbase.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAccount.h"

FOUNDATION_EXPORT NSString *const BR_AUTHCODE_NOTIFICATION_TYPE;
FOUNDATION_EXPORT NSString *const BR_AUTHCODE_URL_KEY;

typedef void (^AccountHandler)(BRAccount *account, NSError *error);
typedef void (^LoginHandler)(NSError *error);

@interface BRCoinbase : NSObject

+ (BOOL)isAuthenticated;

+ (NSString *)getClientId;
+ (NSString *)getClientSecret;
+ (NSString *)getCallbackUrl;

+ (void)setClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret;

+ (void)login:(LoginHandler)handler;
+ (void)loginWithScope:(NSArray *)permissions withHandler:(LoginHandler)handler;
+ (void)logout;

+ (void)handleUrl:(NSURL *)url;

+ (void)getAccount:(AccountHandler)handler;

@end
