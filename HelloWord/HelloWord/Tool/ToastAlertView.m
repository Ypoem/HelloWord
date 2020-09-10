//
//  ToastAlertView.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "ToastAlertView.h"
#import "GlobleFile.h"
@interface ToastAlertView()
/**
 文字背景颜色, 默认0x333333
 */
@property (nonatomic) UIColor *textBackgroundColor;

/**
 文字背景圆角, 默认5
 */
@property (nonatomic) CGFloat cornerRadius;

/**
 文字字体, 默认15号系统字体
 */
@property (nonatomic) UIFont *font;

/**
 文字颜色, 默认白色
 */
@property (nonatomic) UIColor *textColor;

/**
 文字行数, 默认为0不限行数
 */
@property (nonatomic) NSInteger numberOfLines;

/**
 文字背景跟屏幕边缘的最小距离, 默认20
 */
@property (nonatomic) CGFloat minSpaceFromScreenEdge;

/**
 文字纵向边距, 默认15
 */
@property (nonatomic) CGFloat textVerticalMargin;

/**
 文字横向边距, 默认15
 */
@property (nonatomic) CGFloat textHorizonalMargin;

/**
 文字展示时间, 单位是秒, 默认1.5
 */
@property (nonatomic) CGFloat showTime;

/**
 是否有弹出动画, 默认YES
 */
@property (nonatomic) BOOL animate;

/**
 弹出动画时长, 单位是秒, 默认0.3
 */
@property (nonatomic) CGFloat duration;

@end
@implementation ToastAlertView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textBackgroundColor = Color_R_G_B_A(51, 51, 51, 1);
        _cornerRadius = 3;
        _font = [UIFont systemFontOfSize:12];
        _textColor = UIColor.whiteColor;
        _numberOfLines = 0;
        _minSpaceFromScreenEdge = 50;
        _textVerticalMargin = 15;
        _textHorizonalMargin = 15;
        _showTime = 1.5;
        _animate = YES;
        _duration = 0.5;
    }
    return self;
}

+ (void)showText:(NSString *)text {
    [[[self alloc] init] showText:text];
}

- (void)showText:(NSString *)text {
    text = [self stringOfValue:text defaultValue:@" "];
    
    CGFloat x = 0,
            y = 0,
            w = APP_SCREEN_WIDTH - self.minSpaceFromScreenEdge * 2 - self.textHorizonalMargin * 2,
            h = MAXFLOAT;
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(w, h)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: self.font}
                                         context:nil].size;
    w = textSize.width + self.textHorizonalMargin * 2;
    h = textSize.height + self.textVerticalMargin * 2;
    x = (APP_SCREEN_WIDTH - w) / 2; y = (APP_SCREEN_HEIGHT - h) / 2;
    self.frame = CGRectMake(x, y, w, h);
    self.backgroundColor = self.textBackgroundColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;
    [APP_WINDOW addSubview:self];
    
    x = self.textHorizonalMargin;
    y = self.textVerticalMargin;
    w = self.frame.size.width - x * 2;
    h = self.frame.size.height - y * 2;
    
    UILabel *lb = [self createLabelWithFrame:CGRectMake(x, y, w, h) backgroundColor:UIColor.clearColor text:text lines:self.numberOfLines font:self.font textColor:self.textColor align:NSTextAlignmentCenter breakMode:NSLineBreakByWordWrapping];
    [self addSubview:lb];
    
    if (self.animate) {
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [self disappear];
        }];
    } else {
        [self disappear];
    }
}

- (void)disappear {
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.showTime * NSEC_PER_SEC));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:self.duration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    });
}

- (NSString *)stringOfValue:(id)value defaultValue:(NSString *)dft {
    if (!value) {
        return dft;
    }
    if ([value isKindOfClass:NSNull.class]) {
        return dft;
    }
    NSString *valueStr = [NSString stringWithFormat:@"%@", value];
    if (!valueStr.length) {
        return dft;
    }
    NSCharacterSet *whitespaceAndNewline = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedString = [valueStr stringByTrimmingCharactersInSet:whitespaceAndNewline];
    if (!trimmedString.length) {
        return dft;
    }
    return valueStr;
}

- (UILabel *)createLabelWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor text:(NSString *)text lines:(NSInteger)lines font:(UIFont *)font textColor:(UIColor *)textColor align:(NSTextAlignment)align breakMode:(NSLineBreakMode)breakMode {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = backgroundColor;
    label.text = text;
    label.numberOfLines = lines;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = align;
    label.lineBreakMode = breakMode;
    return label;
}

@end
