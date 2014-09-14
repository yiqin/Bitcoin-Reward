//
//  BRExchange.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRRequest.h"

typedef void (^PriceHandler)(NSString *price, NSError *error);
typedef void (^CurrenciesHandler)(NSArray* currencies, NSError *error);

@interface BRExchange : NSObject

+ (void)getTransfers:(BRResponseHandler)handler;

+ (void)getBuyPrice:(NSNumber*)qty withHandler:(PriceHandler)handler;
+ (void)getSellPrice:(NSNumber*)qty withHandler:(PriceHandler)handler;
+ (void)getSpotRate:(NSString *)currency withHandler:(PriceHandler)handler;

+ (void)buyBitcoin:(NSNumber*)qty withHandler:(BRResponseHandler)handler;
+ (void)sellBitcoin:(NSNumber*)qty withHandler:(BRResponseHandler)handler;

+ (void)getExchangeRates:(BRResponseHandler)handler;
+ (void)getSupportedCurrencies:(CurrenciesHandler)handler;

@end
