//
//  ViewController.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"

#import "BitcoinRewarding.h"

@interface ViewController ()

@property UIButton *rightButton;
@property NSMutableArray *transactions;
@property BRAccount *account;

@end

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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAuthCode:) name:BR_AUTHCODE_NOTIFICATION_TYPE object:nil];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self auth];
}

- (void)getAuthCode:(NSNotification *)notification
{
    NSLog(@"%@",[[notification userInfo] objectForKey:BR_AUTHCODE_URL_KEY]);
    
    // We need this url link when we login at the first time.
    [[UIApplication sharedApplication] openURL:[[notification userInfo] objectForKey:BR_AUTHCODE_URL_KEY]];
}


// Get uers data. That's necessary to setup.
- (void)auth
{
    NSLog([BRCoinbase isAuthenticated] ? @"Yes" : @"No");
    
    if (![BRCoinbase isAuthenticated]) {
        [BRCoinbase login:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [BRCoinbase getAccount:^(BRAccount *account, NSError *error) {
                    self.account = account;
                    [BRExchange getExchangeRates:^(NSDictionary *entries, NSError *error) {
                        
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


- (void)test
{
    // Hey, this is one line code implementation.
    
    
    
    
    
    
    // O2 API , one line code impelemtation
    [BitcoinRewarding sendO2];
    
    
    
    
    
    
    
    
    
    
    /*
    [BitcoinRewarding sendO2WithBlock:^(BOOL succeeded, NSError *error) {
     
    }];
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
