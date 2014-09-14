//
//  BRAccount.h
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRTransaction.h"
#import "BRRequest.h"

typedef void (^TransactionsHandler)(NSArray *transactions, NSError *error);
typedef void (^BalanceHandler)(NSString *balance, NSError *error);
typedef void (^AddressHandler)(NSString *address, NSError *error);
typedef void (^AddressListHandler)(NSArray *addressList, NSError *error);

@interface BRAccount : NSObject
@property NSString *name;
@property NSString *email;
@property NSString *balance;
@property NSString *cbId;
@property NSString *nativeCurrency;
@property NSString *timeZone;
@property NSString *buyLevel;
@property NSString *buyLimit;
@property NSString *sellLevel;
@property NSString *sellLimit;

- (void)getTransactions:(TransactionsHandler)handler;

- (void)getAccountChanges:(BRResponseHandler)handler;

- (void)getCurrentBalance:(BalanceHandler)handler;
- (void)getReceiveAddress:(AddressHandler)handler;
- (void)getAddresses:(BRResponseHandler)handler;
- (void)getContacts:(BRResponseHandler)handler;

@end
