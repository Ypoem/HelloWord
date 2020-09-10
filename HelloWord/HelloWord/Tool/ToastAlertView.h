//
//  ToastAlertView.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastAlertView : UIView
/**
 弹出文字, 类方法, 全部使用默认属性
 @param text 文字
 */
+ (void)showText:(nullable NSString *)text;
@end

NS_ASSUME_NONNULL_END
