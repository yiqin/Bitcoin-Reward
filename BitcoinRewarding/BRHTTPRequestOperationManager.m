//
//  BRHTTPRequestOperationManager.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRHTTPRequestOperationManager.h"

@implementation BRHTTPRequestOperationManager

+ (instancetype)manager {
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
		
        NSString *apiKey = @"d3OFRimpax4xe06O";
        NSString *apiSecret = @"JPT8loHR857nFhktLERws8pJ8cGJHbpD";
        
        // 1
        [self.requestSerializer setValue:apiKey forHTTPHeaderField:@"ACCESS_KEY"];
        
        
        //2
        
        // [self.requestSerializer setValue:apiSecret forKey:@"ACCESS_SIGNATURE"];
        
        
        
        // 3
        NSNumber *currentTime = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] * 1000];
        NSString *nonce =[ NSString stringWithFormat:@"%i", [currentTime integerValue]];
        [self.requestSerializer setValue:nonce forHTTPHeaderField:@"ACCESS_NONCE"];
    }
    return self;
}


@end
