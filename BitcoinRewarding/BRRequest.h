//
//  BRRequest.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQNetworking/YQNetworking.h"

typedef void (^BRResponseHandler)(id result, NSError* error);

@interface BRRequest : NSObject
+ (void)authorizedRequest:(BRResponseHandler)handler;
+ (void)getRequest:(NSString *)url withHandler:(BRResponseHandler)handler;
@end
