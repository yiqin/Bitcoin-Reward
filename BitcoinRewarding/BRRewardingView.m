//
//  BRRewardingView.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "BRRewardingView.h"

@interface BRRewardingView ()

@property UIButton *acceptButton;

@end

@implementation BRRewardingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self createAcceptButton];
        if (<#condition#>) {
            <#statements#>
        }
        
    }
    return self;
}

- (void)createAcceptButton
{
    self.acceptButton = [[UIButton alloc] initWithFrame:CGRectMake((320-70)*0.5, 200, 70, 50)];
    [self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
    self.acceptButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [self.acceptButton addTarget:self action:@selector(accept) forControlEvents:UIControlEventTouchUpInside];
    self.acceptButton.backgroundColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0];
    [self addSubview:self.acceptButton];
}

- (void)accept
{
    [BitcoinRewarding sendO2WithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Send bitcoin successfully.");
            
            
            
        }
        
    }];
}

@end
