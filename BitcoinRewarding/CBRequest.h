//
//  CBRequest.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQNetworking/YQNetworking.h"

typedef void (^CBResponseHandler)(id result, NSError* error);

@interface CBRequest : NSObject
+ (void)authorizedRequest:(CBResponseHandler)handler;
+ (void)getRequest:(NSString *)url withHandler:(CBResponseHandler)handler;
@end
