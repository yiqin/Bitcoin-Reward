//
//  BitcoinRewarding.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YQParse.h"
#import "BRCoinbase.h"
#import "BRTransaction.h"
#import "BRExchange.h"

@interface BitcoinRewarding : NSObject

+ (void)setApplicationId:(NSString*)applicationId
                  apiKey:(NSString*)apiKey
             bitcoinUnit:(NSNumber*)bitcoinUnit
            emailAddress:(NSString*)emailAddress
                 message:(NSString*)message;

+ (void)updateEmailAddress:(NSString*)emailAddress;

+ (NSString*)getApplicationId;
+ (NSString*)getApiKey;
+ (NSNumber*)getBitcoinUnit;
+ (NSString*)getEmailAddress;
+ (NSString*)getMessage;


+ (void)sendO2;
+ (void)sendO2WithBlock:(void(^)(BOOL succeeded, NSError *error))block;

@end
