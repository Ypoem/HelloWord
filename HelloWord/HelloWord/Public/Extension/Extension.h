//
//  Extension.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/**
 * 获取导航栏+状态栏的高度
 * @return 导航栏+状态栏的高度
 */
FOUNDATION_EXTERN CGFloat TopBarHeight(void);
/**
 收起键盘
 */
FOUNDATION_EXTERN void ResignFirstResponder(void);

/**
 获取当前控制器的RootViewController
 @return UIViewController
 */
FOUNDATION_EXTERN UIViewController * GetRootViewController (void);

/**
 获取当前控制器的UINavigationController
  @return UINavigationController
 */
FOUNDATION_EXTERN UINavigationController * TopViewController(void);
FOUNDATION_EXPORT UIViewController * currentViewController(void);

FOUNDATION_EXPORT CGFloat StaH(void);
FOUNDATION_EXPORT UIWindow * AppKeyWindow(void);

#pragma mark ====================== 颜色扩展 =======================

@interface UIColor (YuColor)
/**
 *  16进制颜色转换
 */
+ (nullable UIColor *)colorWithHexString:(NSString *)hexString NS_SWIFT_NAME(hex(_:));
/**
 获取layer上某个点的颜色

 @param point point
 @param layer 想要获取的layer
 @return color
 */
+ (UIColor *_Nonnull)colorOfPoint:(CGPoint)point layer:(CALayer *_Nonnull)layer;
@end

#pragma mark ====================== 字符串拓展 =======================
@interface NSString(YuString)
@property (nonatomic, assign, readonly) BOOL isEmpty;
/**
 字符串转换为时间戳

 @param string 字符串

 @return 时间戳字符串
 */
+ (NSString *)timeIntervalFormString:(NSString *)string dateFormat:(NSString *)dateFormat;
/**
 时间戳转时间

 @param timeInterval 时间戳

 @return 时间字符串
 */
+ (NSString *)timeIntervalToTimestring:(NSString *)timeInterval dateFormat:(NSString *)dateFormat;

- (NSString *)substringToIndex:(NSUInteger)to;

@end
NS_ASSUME_NONNULL_END
