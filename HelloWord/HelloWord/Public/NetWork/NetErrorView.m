//
//  NetErrorView.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "NetErrorView.h"
#import "GlobleFile.h"
typedef void(^retryBlock)(id retryView);

@interface NetErrorView ()

@property (nonatomic, copy) retryBlock block;
@property (nonatomic, assign) BOOL keyboardShow;
@property (nonatomic, strong) UILabel * tipsLabel;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, assign) NetworkDataState netSate;
@property (nonatomic, strong) UIImageView * withoutNetImageView;

@end
@implementation NetErrorView

- (instancetype)initWithFrame:(CGRect)frame state:(NetworkDataState)state retryBlock:(void(^)(id retryView))retryBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColorString(@"FFFFFF");
        self.netSate = state;
        self.block = retryBlock;
        self.tipsLabel.textColor = RGBColorString(@"666666");

        if (state == NetworkDataStateNetwokError) {
            self.contentView.frame = CGRectMake(0, 0, 180, 156 + 45);
            self.withoutNetImageView.frame = CGRectMake(0, 0, 180, 156);
            self.withoutNetImageView.image = [UIImage imageNamed:@"WithoutNet"];
        } else {
            self.contentView.frame = CGRectMake(0, 0, 196, 154 + 45);
            self.withoutNetImageView.frame = CGRectMake(0, 0, 196, 154);
            self.withoutNetImageView.image = [UIImage imageNamed:@"WithoutData"];
        }
        self.withoutNetImageView.userInteractionEnabled = YES;
        self.contentView.center = CGPointMake(self.center.x, self.frame.size.height/2);
        self.tipsLabel.frame = CGRectMake(0, CGRectGetMaxY(self.withoutNetImageView.frame) + 29, self.contentView.frame.size.width, 16);
        
        self.tipsLabel.font = pingFangSCRegular(14);
        if (state == NetworkDataStateNetwokError) {
            self.tipsLabel.text = @"轻触屏幕，重新召唤网君";
        } else {
            self.tipsLabel.text = @"对不起，目前没有数据";
        }
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.withoutNetImageView];
        [self.contentView addSubview:self.tipsLabel];
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardDidShowNotification) name:UIKeyboardDidShowNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardDidHideNotification) name:UIKeyboardDidHideNotification object:nil];
        
    }
    return self;
}

- (void)keyboardDidShowNotification {
    self.keyboardShow = YES;
}

- (void)keyboardDidHideNotification {
    self.keyboardShow = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.netSate == NetworkDataStateNetwokError) {
        if (self.block) {
            self.block(self);
        }
    }
    if (self.keyboardShow) {
        [self resignFirstResponder];
    }
}


#pragma mark - lazy load
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
    }
    return _tipsLabel;
}

- (UIImageView *)withoutNetImageView {
    if (!_withoutNetImageView) {
        _withoutNetImageView = [[UIImageView alloc] init];
    }
    return _withoutNetImageView;
}


- (void)setEmptyMessage:(NSString *)emptyMessage {
    if (emptyMessage.length) {
        self.tipsLabel.text = emptyMessage;
    }
}

@end
