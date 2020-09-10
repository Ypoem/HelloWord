//
//  YuAlertView.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^AlertViewBlcok)(UIButton * alertButton);

@interface YuAlertView : UIView
+ (instancetype)sharedAlertView;

/**
 * 提示框
 * @param title 提示语标题
 * @param cancleTitle 取消按钮
 * @param sureTitle 确认按钮
 * @parm  message 提示详细信息
 */
- (void)alertWithTitle:(NSString *)title
               Message:(NSString *)message
           cancleTitle:(NSString *)cancleTitle
             sureTitle:(NSString *)sureTitle
                cancle:(AlertViewBlcok)cancle
                  sure:(AlertViewBlcok)sure;

/**
 * 提示框 提示信息为红色
 * @param title 提示语标题
 * @param cancleTitle 取消按钮
 * @param sureTitle 确认按钮
 * @parm  message 提示详细信息(红色字体)
 */
- (void)alertErrorWithTitle:(NSString *)title
                    Message:(NSString *)message
                cancleTitle:(NSString *)cancleTitle
                  sureTitle:(NSString *)sureTitle
                     cancle:(AlertViewBlcok)cancle
                       sure:(AlertViewBlcok)sure;

/**
 * 提示框 单个蓝字按钮
 * @param title 提示语标题
 * @param sureTitle 确认按钮
 * @parm  message 提示详细信息
 */
- (void)alertWithTitle:(NSString *)title
               Message:(NSString *)message
             sureTitle:(NSString *)sureTitle
                  sure:(AlertViewBlcok)sure;

@end

NS_ASSUME_NONNULL_END
