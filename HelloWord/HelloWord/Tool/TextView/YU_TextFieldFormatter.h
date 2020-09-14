//
//  YU_FormatTextField.h
//  Demo
//
//  Created by 张诗雨 on 2019/4/9.
//  Copyright © 2019 张诗雨. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 1.初始化一个textField
 * 2.初始化 YU_TextFieldFormatter
 * 3.设置 textfeild.delegate = (YU_TextFieldFormatter *)
 
 *例:
 *UITextField *textField = [UITextField new];
 *YU_TextFieldFormatter *formatter = [[YU_TextFieldFormatter alloc] initWithTextField:textField lengthArray:@[@3, @4, @4]];
 *textField.delegate = formatter;
 *[self.view addSubview:textField];
 * 电话 @[@3, @4, @4];
 * 银行卡@[@4, @4, @4, @4, @4];
 
* 如果textfeild需要使用自己的代理方法 可设置textField.delegate = self;
* 在代理方法中调用YU_TextFieldFormatter 的"-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string"方法;
 🌰:
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 YU_TextFieldFormatter *formatter = [YU_TextFieldFormatter getFormatterWith:textFeild]
 BOOL retVal = [formatter textField:textField shouldChangeCharactersInRange:range replacementString:string];
 //下面为textfeild实现逻辑
 
 return retVal;
 }
 */

#define FORMATTER_FLAG @"yu_formatter"

@interface YU_TextFieldFormatter : NSObject<UITextFieldDelegate>
/**
 * 初始化
 * param lengthArray: formatter格式  请设置最大输入内容样式
 */

-(instancetype)initWithLengthArray:(NSArray<NSNumber*>*)lengths;

/**
*  关联textfield
* param textField: 需要设置的formatter的textField
*/
- (void)setAssociatedTextField:(UITextField *)textField;

/**
 * get方法
 * param textField: 设置的formatter的textField
 */
+ (instancetype)getFormatterWith:(UITextField *)textField;
@end


