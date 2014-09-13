//
//  YQButton.h
//  RT
//
//  Created by yiqin on 8/25/14.
//  Copyright (c) 2014 yiqin.info All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQButton : UIButton

@property (strong, nonatomic) UIColor* regularColor;
@property (strong, nonatomic) UIColor* highlightedColor;

@end

@interface YQOneButton : YQButton

@end

@interface YQTwoButton : YQButton

@end

@interface YQThreeButton : YQButton

@end

@interface YQFourButton : YQButton

@end

@interface YQFiveButton : YQButton

@end

@interface YQButtonWithImage : YQButton

// mutable subclass(NString, NSDictionary)
@property (strong, nonatomic) NSString* regularImage;
@property (strong, nonatomic) NSString* selectedImage;
@property (nonatomic) BOOL isBackgroundTransparent;
@property (nonatomic) BOOL hasAnimation;

- (instancetype)initWithFrame:(CGRect)frame image:(NSString*)image selectedImage:(NSString*)selectedImage;
- (instancetype)initWithCenterPoin:(CGPoint)centerPoint imageSize:(CGSize)imageSize image:(NSString*)image selectedImage:(NSString*)selectedImage;

@end

@interface YQButtonWithParse : YQButtonWithImage

@property (strong, nonatomic) NSString* objectId;

@end
