//
//  YU_FormatTextField.h
//  Demo
//  Created by 张诗雨 on 2019/4/9.
//
//  Copyright © 2019 张诗雨. All rights reserved.
//

#import "YU_TextFieldFormatter.h"
#import <objc/runtime.h>
#import "Extension.h"
@interface YU_TextFieldFormatter ()
@property (copy, nonatomic) NSArray<NSNumber*> *lengthArray;
@property (nonatomic) int maxLength;
@end

@implementation YU_TextFieldFormatter

-(instancetype)initWithLengthArray:(NSArray<NSNumber*>*)lengths{
    self = [super init];
    if (self) {
        _lengthArray = lengths;
        _maxLength = 0;
        for (NSNumber *num in lengths) {
            _maxLength += num.intValue;
        }
    }
    return self;
}

- (void)setAssociatedTextField:(UITextField *)textField {
    objc_setAssociatedObject(textField, FORMATTER_FLAG, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (instancetype)getFormatterWith:(UITextField *)textField {
    YU_TextFieldFormatter *formatter = objc_getAssociatedObject(textField, FORMATTER_FLAG);
    return formatter;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length > 1) {
        return NO;
    }
    //限制输入数字
    NSString *text = [textField text];
//    NSInteger count = [text length];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789Xx\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
//    NSLog(@"length===%ld, location===%ld", range.length, range.location);
    NSInteger index = [self selectedRangeWithTextField:textField].location;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length + 1 > _maxLength && ![string isEqualToString:@""]) {
        return NO;
    }
    NSString *newString = [self formattedString:text];
//    NSLog(@"newString length = %lu, count = %ld", newString.length , count);
//    NSLog(@"self index = %ld",index);
    
    NSString *frontString = [[newString yu_substringToIndex:index] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *postString = [[newString substringFromIndex:index] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string isEqualToString:@""]) {
        index = MIN(newString.length, index);
        frontString = [frontString yu_substringToIndex:frontString.length - 1];
    } else {
        frontString = newString = [NSString stringWithFormat:@"%@%@", frontString, string];
    }
    newString = [NSString stringWithFormat:@"%@%@", frontString, postString];
    newString = [self formattedString:newString];
    [textField setText:newString];
    [self setSelectedRange:NSMakeRange([self formattedString:frontString].length, 0) textField:textField];
    return NO;
}

-(NSString *)formattedString:(NSString *)str {
    NSString *new_str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789Xx\b"];
    int pivot = 0;
    while(new_str.length > 0) {
        if (pivot >= _lengthArray.count) {
            break;
        }
        int subLength = _lengthArray[pivot].intValue;
        NSString* subString = [new_str yu_substringToIndex:MIN(new_str.length, subLength)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == subLength) {
            newString = [newString stringByAppendingString:@" "];
        }
        new_str = [new_str substringFromIndex:MIN(new_str.length,subLength)];
        pivot++;
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    return newString;
}

- (NSRange)selectedRangeWithTextField:(UITextField *)textfield {
    UITextPosition* beginning = textfield.beginningOfDocument;
    
    UITextRange* selectedRange = textfield.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [textfield offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textfield offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range textField:(UITextField *)textfield {
    UITextPosition* beginning = textfield.beginningOfDocument;
    UITextPosition* startPosition = [textfield positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [textfield positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [textfield textRangeFromPosition:startPosition toPosition:endPosition];
    [textfield setSelectedTextRange:selectionRange];
}
@end
