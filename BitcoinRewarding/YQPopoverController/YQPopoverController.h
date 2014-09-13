/*
 Version 0.2.2
 
 YQPopoverController is available under the MIT license.
 
 Copyright © 2013 Nicolas CHENG
 
 Permission is hereby granted, free of charge, to any person obtaining a copy 
 of this software and associated documentation files (the "Software"), to deal 
 in the Software without restriction, including without limitation the rights 
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
 copies of the Software, and to permit persons to whom the Software is 
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included 
 in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol YQPopoverControllerDelegate;
@class YQPopoverTheme;

#ifndef YQ_POPOVER_DEFAULT_ANIMATION_DURATION
    #define YQ_POPOVER_DEFAULT_ANIMATION_DURATION    .25f
#endif

#ifndef YQ_POPOVER_MIN_SIZE
    #define YQ_POPOVER_MIN_SIZE                      CGSizeMake(240, 160)
#endif

typedef NS_OPTIONS(NSUInteger, YQPopoverArrowDirection) {
    YQPopoverArrowDirectionUp = 1UL << 0,
    YQPopoverArrowDirectionDown = 1UL << 1,
    YQPopoverArrowDirectionLeft = 1UL << 2,
    YQPopoverArrowDirectionRight = 1UL << 3,
    YQPopoverArrowDirectionNone = 1UL << 4,
    YQPopoverArrowDirectionAny = YQPopoverArrowDirectionUp | YQPopoverArrowDirectionDown | YQPopoverArrowDirectionLeft | YQPopoverArrowDirectionRight,
    YQPopoverArrowDirectionUnknown = NSUIntegerMax
};

typedef NS_OPTIONS(NSUInteger, YQPopoverAnimationOptions) {
    YQPopoverAnimationOptionFade = 1UL << 0,            // default
    YQPopoverAnimationOptionScale = 1UL << 1,
    YQPopoverAnimationOptionFadeWithScale = YQPopoverAnimationOptionFade | YQPopoverAnimationOptionScale
};

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface YQPopoverBackgroundView : UIView

@property (nonatomic, strong) UIColor *tintColor                UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *fillTopColor             UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *fillBottomColor          UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *glossShadowColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   glossShadowOffset        UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  glossShadowBlurRadius    UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) NSUInteger  borderWidth              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  arrowBase                UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  arrowHeight              UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *outerShadowColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *outerStrokeColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  outerShadowBlurRadius    UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   outerShadowOffset        UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  outerCornerRadius        UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  minOuterCornerRadius     UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *innerShadowColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *innerStrokeColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  innerShadowBlurRadius    UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   innerShadowOffset        UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger  innerCornerRadius        UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) UIEdgeInsets viewContentInsets    UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *overlayColor             UI_APPEARANCE_SELECTOR;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface YQPopoverController : NSObject <UIAppearanceContainer>

@property (nonatomic, weak) id <YQPopoverControllerDelegate> delegate;

@property (nonatomic, copy) NSArray                            *passthroughViews;
@property (nonatomic, assign) BOOL                              wantsDefaultContentAppearance;
@property (nonatomic, assign) UIEdgeInsets                      popoverLayoutMargins;
@property (nonatomic, readonly, getter=isPopoverVisible) BOOL   popoverVisible;
@property (nonatomic, strong, readonly) UIViewController       *contentViewController;
@property (nonatomic, assign) CGSize                            popoverContentSize;
@property (nonatomic, assign) float                             animationDuration;

@property (nonatomic, strong) YQPopoverTheme                   *theme;

+ (void)setDefaultTheme:(YQPopoverTheme *)theme;
+ (YQPopoverTheme *)defaultTheme;

// initialization

- (id)initWithContentViewController:(UIViewController *)viewController;

// theme

- (void)beginThemeUpdates;
- (void)endThemeUpdates;

// Present popover from classic views methods

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                      animated:(BOOL)animated;

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                      animated:(BOOL)animated
                    completion:(void (^)(void))completion;

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                      animated:(BOOL)animated
                       options:(YQPopoverAnimationOptions)options;

- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                      animated:(BOOL)animated
                       options:(YQPopoverAnimationOptions)options
                    completion:(void (^)(void))completion;

// Present popover from bar button items methods

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item
               permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                               animated:(BOOL)animated;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item
               permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                               animated:(BOOL)animated
                             completion:(void (^)(void))completion;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item
               permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                               animated:(BOOL)animated
                                options:(YQPopoverAnimationOptions)options;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item
               permittedArrowDirections:(YQPopoverArrowDirection)arrowDirections
                               animated:(BOOL)animated
                                options:(YQPopoverAnimationOptions)options
                             completion:(void (^)(void))completion;

// Present popover as dialog methods

- (void)presentPopoverAsDialogAnimated:(BOOL)animated;

- (void)presentPopoverAsDialogAnimated:(BOOL)animated
                            completion:(void (^)(void))completion;

- (void)presentPopoverAsDialogAnimated:(BOOL)animated
                               options:(YQPopoverAnimationOptions)options;

- (void)presentPopoverAsDialogAnimated:(BOOL)animated
                               options:(YQPopoverAnimationOptions)options
                            completion:(void (^)(void))completion;

// Dismiss popover methods

- (void)dismissPopoverAnimated:(BOOL)animated;

- (void)dismissPopoverAnimated:(BOOL)animated
                    completion:(void (^)(void))completion;

- (void)dismissPopoverAnimated:(BOOL)animated
                       options:(YQPopoverAnimationOptions)aOptions;

- (void)dismissPopoverAnimated:(BOOL)animated
                       options:(YQPopoverAnimationOptions)aOptions
                    completion:(void (^)(void))completion;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YQPopoverControllerDelegate <NSObject>
@optional

- (BOOL)popoverControllerShouldDismissPopover:(YQPopoverController *)popoverController;

- (void)popoverControllerDidPresentPopover:(YQPopoverController *)popoverController;

- (void)popoverControllerDidDismissPopover:(YQPopoverController *)popoverController;

- (void)popoverController:(YQPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view;

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(YQPopoverController *)popoverController;

- (void)popoverController:(YQPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface YQPopoverTheme : NSObject

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *fillTopColor;
@property (nonatomic, strong) UIColor *fillBottomColor;

@property (nonatomic, strong) UIColor *glossShadowColor;
@property (nonatomic, assign) CGSize   glossShadowOffset;
@property (nonatomic, assign) NSUInteger  glossShadowBlurRadius;

@property (nonatomic, assign) NSUInteger  borderWidth;
@property (nonatomic, assign) NSUInteger  arrowBase;
@property (nonatomic, assign) NSUInteger  arrowHeight;

@property (nonatomic, strong) UIColor *outerShadowColor;
@property (nonatomic, strong) UIColor *outerStrokeColor;
@property (nonatomic, assign) NSUInteger  outerShadowBlurRadius;
@property (nonatomic, assign) CGSize   outerShadowOffset;
@property (nonatomic, assign) NSUInteger  outerCornerRadius;
@property (nonatomic, assign) NSUInteger  minOuterCornerRadius;

@property (nonatomic, strong) UIColor *innerShadowColor;
@property (nonatomic, strong) UIColor *innerStrokeColor;
@property (nonatomic, assign) NSUInteger  innerShadowBlurRadius;
@property (nonatomic, assign) CGSize   innerShadowOffset;
@property (nonatomic, assign) NSUInteger  innerCornerRadius;

@property (nonatomic, assign) UIEdgeInsets viewContentInsets;

@property (nonatomic, strong) UIColor *overlayColor;

+ (instancetype)theme;
+ (instancetype)themeForIOS6;
+ (instancetype)themeForIOS7;

@end
