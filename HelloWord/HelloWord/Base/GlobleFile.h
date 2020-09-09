//
//  GlobleFile.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#ifndef GlobleFile_h
#define GlobleFile_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Extension.h"

#pragma mark - 强弱引用 -
// 弱引用
#define WEAK_SELF                  __weak typeof(self) weakSelf = self
// 强引用
#define STRONG_SELF                __strong typeof(self) strongSelf = weakSelf

#define APP_SCREEN_BOUNDS               [[UIScreen mainScreen] bounds]
#define APP_SCREEN_WIDTH                (APP_SCREEN_BOUNDS.size.width)
#define APP_SCREEN_HEIGHT               (APP_SCREEN_BOUNDS.size.height)
#define APP_WINDOW                      AppKeyWindow()
#define APP_NAVITOPHEIGHT               TopBarHeight()
#define SystemVersion                   [[[UIDevice currentDevice] systemVersion] floatValue]
#define APP_STATUSBARHEIGHT             StaH()


//正常字体
#define NormalFont(fontValue)        [UIFont systemFontOfSize:fontValue]
//加粗字体
#define BoldFont(fontValue)          [UIFont boldSystemFontOfSize:fontValue]
UIKIT_STATIC_INLINE UIFont *pingFangSCRegular(fontSize) {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    if (nil == font) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

UIKIT_STATIC_INLINE UIFont *pingFangSCMedium(fontSize) {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    if (nil == font) {
        return [UIFont systemFontOfSize:fontSize];
    }
    return font;
}
//颜色
#define RGBColorString(colorStr)     [UIColor colorWithHexString:colorStr]
#define Color_R_G_B_A(R,G,B,A)       [UIColor colorWithRed:R/255.f green:G/255.f  blue:B/255.f  alpha:A]

#endif /* GlobleFile_h */
