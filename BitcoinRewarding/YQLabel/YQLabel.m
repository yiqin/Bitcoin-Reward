//
//  YQLabel.m
//  WebScraper
//
//  Created by yiqin on 7/30/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQLabel.h"

@implementation YQLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
	if (self) {
        
	}
	return self;
}

@end


@implementation YQLabelWithFixedWidth

- (id)initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame font:font text:text];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment
{
    self = [self initWithFrame:frame font:font text:text];
    if (self) {
        self.textAlignment = textAlignment;
    }
    return self;
}

- (id)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment fontSize:(float)fontSize labelEstimatedWidth:(float)labelEstimatedWidth afterUILabel:(UILabel *)label
{
    CGRect tempFrame = CGRectMake(0, 0, labelEstimatedWidth, 1024.0);
    UIFont *tempFont = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    self = [self initWithFrame:tempFrame font:tempFont text:text textAlignment:textAlignment];
    if (self) {
        [self afterUILabel:label];
    }
    return self;
}

- (id)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment fontSize:(float)fontSize labelEstimatedWidth:(float)labelEstimatedWidth afterFrame:(CGRect)referenceFrame
{
    CGRect tempFrame = CGRectMake(0, 0, labelEstimatedWidth, 1024.0);
    UIFont *tempFont = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    self = [self initWithFrame:tempFrame font:tempFont text:text textAlignment:textAlignment];
    if (self) {
        [self afterFrame:referenceFrame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text
{
    // or "[text length] <1"
    if (text == nil) {
        text = @"NULL";
    }
    self.font = font;
    self.text = text;
    self.numberOfLines = 0;
    CGFloat maxheight = 1024.0;
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, maxheight)];
    [self sizeToFit];
    CGFloat labelHeight = self.frame.size.height;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, labelHeight);
}

- (void)setTextAndUpdateFrame:(NSString *)text
{
    [self setFrame:self.frame font:self.font text:text];
    [self afterUILabel:self.afterUILabel];
}

- (void)afterUILabel:(UILabel *)label
{
    if (label) {
        if (self.afterUILabel != label) {
            self.afterUILabel = label;
        }
        [self afterFrame:label.frame];
    }
}

- (void)afterFrame:(CGRect)referenceFrame
{
    CGRect tempFrame = self.frame;
    if (self.textAlignment == NSTextAlignmentLeft || self.textAlignment == NSTextAlignmentCenter) {
        self.frame = CGRectMake(CGRectGetMinX(referenceFrame), CGRectGetMaxY(referenceFrame)+5, CGRectGetWidth(tempFrame), CGRectGetHeight(tempFrame));
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        self.frame = CGRectMake(CGRectGetMinX(referenceFrame)+CGRectGetWidth(referenceFrame)-CGRectGetWidth(tempFrame), CGRectGetMaxY(referenceFrame)+5, CGRectGetWidth(tempFrame), CGRectGetHeight(tempFrame));
    }
}

@end