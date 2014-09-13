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
@property UIView *headerView;
@property UILabel *headerLabel;
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    BOOL ios7 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.transactions = [[NSMutableArray alloc] init];
    
    int headerHeight;
    if (ios7) {
        headerHeight = 70;
    } else {
        headerHeight = 50;
    }
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, headerHeight)];
    [self.headerView setBackgroundColor:[UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0]];
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, headerHeight - 50 + 14, 200, 22)];
    [self.headerLabel setText:@"Coinbase"];
    [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
    [self.headerLabel setBackgroundColor:[UIColor clearColor]];
    [self.headerLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    self.headerLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.headerLabel];
    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake((320-70)*0.5, 300, 70, 50)];
    [self.rightButton setTitle:@"Send" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [self.rightButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.backgroundColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0];
    [self.view addSubview:self.rightButton];
    
    [self.view addSubview:self.headerView];
    
    
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
    
    NSLog([BRCoinbase isAuthenticated] ? @"Yes" : @"No");
}

- (void)test {
    
    // NSLog(@"Auth or not", [Coinbase isAuthenticated]);
    
    // We don't use Authenticated here.
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
    
    [CBTransaction send:@0.002 to:@"12aRtYy5QmxWMSWPEcMdEHGRazzg7bRGiN" withNotes:@"Hi" withHandler:^(CBTransaction *transaction, NSError *error) {
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
