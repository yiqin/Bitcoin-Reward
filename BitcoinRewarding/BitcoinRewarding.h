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

@interface BitcoinRewarding : NSObject

+ (void)setApplicationId:(NSString*)applicationId
                  apiKey:(NSString*)apiKey
             bitcoinUnit:(NSNumber*)bitcoinUnit
            emailAddress:(NSString*)emailAddress
                 message:(NSString*)message;

+ (NSString*)getApplicationId;
+ (NSString*)getApiKey;
+ (NSNumber*)getBitcoinUnit;
+ (NSString*)getEmailAddress;
+ (NSString*)getMessage;

@end
