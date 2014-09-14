//
//  BRTransaction.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRRequest.h"

@class BRTransaction;

typedef void (^TransactionHandler)(BRTransaction *transaction, NSError *error);
typedef void (^RequestActionHandler)(BOOL success, NSError *error);

@interface BRTransaction : NSObject
@property NSString *name;
@property NSString *email;
@property NSString *amount;
@property NSString *timestamp;
@property NSString *hash;
@property NSString *transactionId;
@property BOOL sender;
@property BOOL request;

+ (void)send:(NSNumber*)amount to:(NSString*)address withNotes:(NSString*)notes withHandler:(TransactionHandler)handler;
+ (void)request:(NSNumber*)amount from:(NSString*)address withNotes:(NSString*)notes withHandler:(TransactionHandler)handler;

+ (void)resend:(NSString*)requestId withHandler:(RequestActionHandler)handler;
+ (void)cancel:(NSString*)requestId withHandler:(RequestActionHandler)handler;

+ (void)complete:(NSString*)requestId withHandler:(TransactionHandler)handler;
@end
