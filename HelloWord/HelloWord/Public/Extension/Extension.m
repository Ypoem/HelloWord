//
//  Extension.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "Extension.h"
#import "GlobleFile.h"
/**收起键盘*/
void KWResignFirstResponder() {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
}
/**
 获取当前控制器的RootViewController
 @return UIViewController
 */
UIViewController * GetRootViewController () {
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}
/**
 获取当前控制器的UINavigationController
 @return UINavigationController
 */
UINavigationController * TopViewController () {
    UIViewController * rootViewController = GetRootViewController();
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootViewController;
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)rootViewController;
        NSUInteger count = tabVC.viewControllers.count;
        NSUInteger selectIndex = tabVC.selectedIndex;
        if (selectIndex >= 0 && selectIndex < count) {
            return (UINavigationController *)[tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
        }
        return nil;
    } else {
        return nil;
    }
}

/**
获取当前控制器的UIViewController

@return UIViewController
*/

UIViewController * currentViewController() {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController* currentViewController = window.rootViewController;
    BOOL runLoopFind = YES;
       while (runLoopFind) {
           if (currentViewController.presentedViewController) {
               currentViewController = currentViewController.presentedViewController;
           } else {
               if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                   currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
               } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                   currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
               } else {
                   break;
               }
           }
       }
       
       return currentViewController;
}
/**
 获取导航栏+状态栏的高度
 @return 导航栏+状态栏的高度
 */
CGFloat KWTopBarHeight()
{
    if (TopViewController()) {
        CGRect frame = TopViewController().navigationBar.frame;
        CGFloat barHeight = frame.size.height;
        CGFloat height = StaH() + barHeight;
        if (@available(iOS 11.0, *)) {
            height = MAX(TopViewController().view.safeAreaInsets.top, StaH()) + barHeight;
        }
        return height;
    }
    return StaH();
}

CGFloat StaH() {
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

UIWindow *AppKeyWindow(){
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene * windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                return windowScene.windows.firstObject;
            }
            return nil;
        }
    }
    return [[UIApplication sharedApplication].windows lastObject];
}
#pragma mark ====================== 颜色扩展 =======================
@implementation UIColor (YuColor)
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] stringByReplacingOccurrencesOfString:@"0x" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
+ (CGFloat)colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
+ (UIColor *)colorOfPoint:(CGPoint)point layer:(CALayer *)layer {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor * color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}
@end
#pragma mark ====================== 字符串扩展 =======================
@implementation NSString (YuString)
- (BOOL)isEmpty {
      if ([self isKindOfClass:[NSAttributedString class]]) {
            NSAttributedString *attr = (NSAttributedString *)self;
            return SafeString(attr.string).length == 0;
        }
        return SafeString(self).length == 0;
}

NSString * SafeString(NSString *input) {
    NSString *result = [input description];
    if (nil == result || [input isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return [result description];
}

/**
 字符串转换为时间戳
 @param string 字符串
 @return 时间戳字符串
 */
+ (NSString *)timeIntervalFormString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    NSDate * date = [dateFormatter dateFromString:string];
    return [NSString stringWithFormat:@"%.f", [date timeIntervalSince1970]];
}
/**
 时间戳转字符串
 @param timeInterval 时间戳
 @return 时间字符串
 */
+ (NSString *)timeIntervalToTimestring:(NSString *)timeInterval dateFormat:(NSString *)dateFormat {
    NSTimeInterval interval = [timeInterval doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter * objDateformat = [[NSDateFormatter alloc] init];
    objDateformat.timeZone = [NSTimeZone localTimeZone];
    [objDateformat setDateFormat:dateFormat];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

@end
