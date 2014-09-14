//
//  BitcoinRewarding.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BitcoinRewarding.h"

@interface BitcoinRewarding ()

@property(nonatomic, strong) NSString *applicationId;
@property(nonatomic, strong) NSString *apiKey;
@property(nonatomic, strong) NSNumber *bitcoinUnit;
@property(nonatomic, strong) NSString *emailAddress;
@property(nonatomic, strong) NSString *message;

@end

@implementation BitcoinRewarding

+ (instancetype)sharedManager
{
    static BitcoinRewarding *sharedYQManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedYQManager = [[self alloc] init];
    });
    return sharedYQManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _applicationId = @"";
        _apiKey = @"";
        _bitcoinUnit = @0.0;
        _emailAddress = @"";
        _message = @"";
    }
    return self;
}

+ (void)setApplicationId:(NSString*)applicationId
                  apiKey:(NSString*)apiKey
             bitcoinUnit:(NSNumber*)bitcoinUnit
            emailAddress:(NSString*)emailAddress
                 message:(NSString*)message
{
    // YO
    // YO comes later.
    // NSString *APIKey = @"63e019db-a4d4-4789-47de-e110cb192239";
    // [YO startWithAPIKey:APIKey];
    
    // Coinbase Authorization
    [BRCoinbase setClientId:@"6b14b1df3e78c4f307d93a6a4cc27e831f075142b5c54e8948c4183e9f34fb19" clientSecret:@"ede9c978a65caf45fd0cfc46d1075f945f2e7b0dbf860fe65d81aa6e2950fa4d"];
    
    // Parse Authorization
    [YQParse setApplicationId:@"puJq7igbK6ZeekBulDQP1aJfVwxcd1vvAWAshHPI"
                   restApiKey:@"pkMzP4R37PZz4yd4vI7rswJHUxSm1oQesO4Fvhs7"];
    
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    shared.applicationId = applicationId;
    shared.apiKey = apiKey;
    shared.bitcoinUnit = bitcoinUnit;
    shared.emailAddress = emailAddress;
    shared.message = message;
}

+ (NSString*)getApplicationId
{
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    return shared.applicationId;
}

+ (NSString*)getApiKey
{
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    return shared.apiKey;
}

+ (NSNumber*)getBitcoinUnit
{
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    return shared.bitcoinUnit;
}

+ (NSString*)getEmailAddress
{
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    return shared.emailAddress;
}

+ (NSString*)getMessage
{
    BitcoinRewarding *shared = [BitcoinRewarding sharedManager];
    return shared.message;
}

@end
