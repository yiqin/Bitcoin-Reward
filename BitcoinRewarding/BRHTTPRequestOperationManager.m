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
    
    return [[self alloc] initWithBaseURL:nil];
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
		
        // url = @"https://coinbase.com/api/v1/transactions";
        
        NSString *apiKey = @"PISZZNEQqmR24CwH";
        NSString *apiSecret = @"pTAwqiBeDfkKE3XjpY77fll7howufZ7o";
        NSNumber *currentTime = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000];
        NSString *nonce =[ NSString stringWithFormat:@"%i", [currentTime integerValue]];
        
        
        // 1
        [self.requestSerializer setValue:apiKey forHTTPHeaderField:@"ACCESS_KEY"];
        
        NSString *body = nil;
        //2
        NSString *message = [NSString stringWithFormat:@"%@%@",nonce,@"https://coinbase.com/api/v1/transactions"];
        
        
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
