//
//  BRHTTPRequestOperationManager.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRHTTPRequestOperationManager.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation BRHTTPRequestOperationManager

+ (instancetype)manager {
    return [[self alloc] initWithBaseURL:nil];
}

+ (instancetype)managerWithURL:(NSString *)url
{
    NSURL *nsurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [[self alloc] initWithBaseURL:nsurl];
}

- (instancetype)init {
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [YQJSONRequestSerializer serializer];
        self.responseSerializer = [YQJSONResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		
        // Wallet2 api key and api secret
        NSString *apiKey = @"PISZZNEQqmR24CwH";
        NSString *apiSecret = @"pTAwqiBeDfkKE3XjpY77fll7howufZ7o";
        NSNumber *currentTime = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000];
        NSString *nonce =[ NSString stringWithFormat:@"%i", [currentTime integerValue]];
        
        // 1
        [self.requestSerializer setValue:apiKey forHTTPHeaderField:@"ACCESS_KEY"];
        
        
        
        /*
        // parameters are a part of message.
        NSDictionary *params = @{@"transaction" : @{
                                         @"to": @"15KFbJu5C4ZQwdYaK6Ddpy8DpW9xT3vcVz",
                                         @"amount": @0.01,
                                         @"notes": @"Send."
                                         }};
        
        NSString *temp = [NSString stringWithFormat:@"%@", params];
        
        NSString *paramsString = @"transaction[to]=15KFbJu5C4ZQwdYaK6Ddpy8DpW9xT3vcVz&transaction[amount]=0.01&transaction[notes]=Send";
        // https://coinbase.com/api/v1/buttonsbutton[name]=test&button[price_string]=1.23&button[price_currency_iso]=USD&button[variable_price]=1
        
        NSDictionary *params1 = @{@"button" : @{
                                          @"name": @"test",
                                          @"price_string": @"1.23",
                                          @"price_currency_iso": @"USD",
                                          @"variable_price":@"1",
                                          }};
        */
        NSString *params1String = @"button[name]=test&button[price_string]=1.23&button[price_currency_iso]=USD&button[variable_price]=1";
        
        //2
        NSString *message = [NSString stringWithFormat:@"%@%@%@",nonce,[url absoluteString],params1String];
        
        
        
        
        NSString *signature = [self hmac:message withKey:apiSecret];
        [self.requestSerializer setValue:signature forHTTPHeaderField:@"ACCESS_SIGNATURE"];
        
        
        // 3
        [self.requestSerializer setValue:nonce forHTTPHeaderField:@"ACCESS_NONCE"];
    }
    return self;
}

- (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i) {
        HMAC = [HMAC stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    }
    
    return HMAC;
}

@end
