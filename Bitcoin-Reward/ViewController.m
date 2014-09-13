//
//  ViewController.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"
#import "CBTransaction.h"
#import "NSString+NSHash.h"
#import "NSDate+TimeAgo.h"
#import "SAMCategories.h"
#import "UIImageView+WebCache.h"
#import "BRCoinbase.h"
#import "CBExchange.h"

@interface ViewController ()

@property UIButton *rightButton;
@property NSMutableArray *transactions;

@property CBAccount *account;
@end

#define PHOTO_TAG 1

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.transactions = [[NSMutableArray alloc] init];
    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake((320-70)*0.5, 300, 70, 50)];
    [self.rightButton setTitle:@"Send" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [self.rightButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.backgroundColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0];
    [self.view addSubview:self.rightButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAuthCode:) name:CB_AUTHCODE_NOTIFICATION_TYPE object:nil];
}

- (void)getAuthCode:(NSNotification *)notification
{
    NSLog(@"%@",[[notification userInfo] objectForKey:CB_AUTHCODE_URL_KEY]);
    
    [[UIApplication sharedApplication] openURL:[[notification userInfo] objectForKey:CB_AUTHCODE_URL_KEY]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self auth];
}

// Get uers data. That's necessary to setup.
- (void)auth
{
    if (![BRCoinbase isAuthenticated]) {
        [BRCoinbase login:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [BRCoinbase getAccount:^(CBAccount *account, NSError *error) {
                    self.account = account;
                    [CBExchange getExchangeRates:^(NSDictionary *entries, NSError *error) {
                        
                    }];
                    
                    [self.account getTransactions:^(NSArray *transactions, NSError *error) {
                        self.transactions = [transactions mutableCopy];
                        
                    }];
                }];
            }
        }];
    } else {
        self.account = nil;
        [self.transactions removeAllObjects];
    }
}


- (void)test {
    
    // NSLog(@"Auth or not", [Coinbase isAuthenticated]);
    
    // We don't use Authenticated to fetch the information of account.
    NSLog([BRCoinbase isAuthenticated] ? @"Yes" : @"No");
    
    if ([BRCoinbase isAuthenticated]) {
        
        NSLog([BRCoinbase isAuthenticated] ? @"Yes" : @"No");
        
        //        [self.account getAccountChanges:^(NSDictionary *result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
        //
        //        [self.account getCurrentBalance:^(NSString *balance, NSError *error) {
        //            NSLog(@"%@", balance);
        //        }];
        //
        //        [self.account getReceiveAddress:^(NSString *address, NSError *error) {
        //            NSLog(@"%@", address);
        //        }];
        //
        //        [self.account getAddresses:^(NSDictionary *result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
        //
        //        [self.account getContacts:^(NSDictionary *result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
        //
        //        [CBExchange getTransfers:^(NSDictionary *result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
        
        //        [CBTransaction request:@0.01 from:@"jbeal24@live.com" withNotes:@"CC" withHandler:^(CBTransaction *transaction, NSError *error) {
        //            __block NSString *tid = transaction.transactionId;
        //            [CBTransaction resend:tid withHandler:^(BOOL success, NSError *error) {
        //
        //                [CBTransaction cancel:tid withHandler:^(BOOL success, NSError *error) {
        //
        //                }];
        //            }];
        //        }];
        
        //        [CBExchange buyBitcoin:@0.01 withHandler:^(NSDictionary *result, NSError *error) {
        //            NSLog(@"%@", result);
        //        }];
    }
    
    
    // They are seperated.
    
    [CBTransaction send:@0.001 to:@"12aRtYy5QmxWMSWPEcMdEHGRazzg7bRGiN" withNotes:@"Hi" withHandler:^(CBTransaction *transaction, NSError *error) {
        if (!error) {
            NSLog(@"Send bitcoin successfully.");
        }
        
        
    }];
    
    //    [CBExchange getBuyPriceForQty:@1 withHandler:^(NSString *price) {
    //        NSLog(@"%@", price);
    //    }];
    //
    //    [CBExchange getSellPriceForQty:@1 withHandler:^(NSString *price) {
    //        NSLog(@"%@", price);
    //    }];
    //
    //    [CBExchange getSpotRateForCurrency:@"USD" withHandler:^(NSString *price) {
    //        NSLog(@"%@", price);
    //    }];
    
    //    [CBExchange getSupportedCurrencies:^(NSDictionary *result, NSError *error) {
    //        NSLog(@"%@", result);
    //    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
