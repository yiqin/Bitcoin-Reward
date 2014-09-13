//
//  YQLabel.h
//  WebScraper
//
//  Created by yiqin on 7/30/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQLabel : UILabel

@end

@interface YQLabelWithFixedWidth : YQLabel

@property (strong, nonatomic) UILabel *afterUILabel;

- (id)initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text;
- (id)initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

- (void)setTextAndUpdateFrame:(NSString *)text;

- (id)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment fontSize:(float)fontSize labelEstimatedWidth:(float)labelEstimatedWidth afterUILabel:(UILabel *)label;
- (id)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment fontSize:(float)fontSize labelEstimatedWidth:(float)labelEstimatedWidth afterFrame:(CGRect)referenceFrame;

@end