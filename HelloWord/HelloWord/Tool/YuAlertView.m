//
//  YuAlertView.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "YuAlertView.h"
#import "GlobleFile.h"

static CGFloat ALERTVIEW_WIDTH  = 270;
static CGFloat ALERTVIEW_HIGHT  = 125;
static CGFloat ALERTVIEW_BUTTON_HIGHT = 50;
@interface YuAlertView()
@property (nonatomic, strong) UIView * markView;
@property (nonatomic, strong) UIView * alertView;

@property (nonatomic, strong) UILabel * lbTitle;
@property (nonatomic, strong) UILabel * lbMessage;

@property (nonatomic, strong) UIButton * btSure;
@property (nonatomic, strong) UIButton * btCancle;


@property (nonatomic, copy) AlertViewBlcok sureBlcok;
@property (nonatomic, copy) AlertViewBlcok cancleBlcok;
@end

@implementation YuAlertView

+ (instancetype)sharedAlertView {
    static YuAlertView * alertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[self alloc] init];
    });
    return alertView;
}

//默认提示框
- (void)alertWithTitle:(NSString *)title
               Message:(NSString *)message
           cancleTitle:(NSString *)cancleTitle
             sureTitle:(NSString *)sureTitle
                cancle:(AlertViewBlcok)cancle
                  sure:(AlertViewBlcok)sure {
    
    self.cancleBlcok = cancle;
    self.sureBlcok = sure;
    self.lbMessage.textColor = Color_R_G_B_A(51, 51, 51, 1);
    [self showAlertViewTitle:title Message:message cancleTitle:cancleTitle sureTitle:sureTitle];
    
}
//单个蓝色按钮
- (void)alertWithTitle:(NSString *)title
               Message:(NSString *)message
             sureTitle:(NSString *)sureTitle
                  sure:(AlertViewBlcok)sure {
    
    self.sureBlcok = sure;
    self.lbMessage.textColor = Color_R_G_B_A(51, 51, 51, 1);
    [self showAlertViewTitle:title Message:message sureTitle:sureTitle];
}
//详细信息为红色
- (void)alertErrorWithTitle:(NSString *)title
                    Message:(NSString *)message
                cancleTitle:(NSString *)cancleTitle
                  sureTitle:(NSString *)sureTitle
                     cancle:(AlertViewBlcok)cancle
                       sure:(AlertViewBlcok)sure {
    
    self.cancleBlcok = cancle;
    self.sureBlcok = sure;
    [self.lbMessage setTextColor:Color_R_G_B_A(244, 51, 60,1)];
    [self showAlertViewTitle:title Message:message cancleTitle:cancleTitle sureTitle:sureTitle];
}


- (void)cleanAlertView {
    for (UIView * x in self.alertView.subviews) {
        [x removeFromSuperview];
    }
    [self.alertView removeFromSuperview];
    [self.markView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)showAlertViewTitle:(NSString *)title Message:(NSString *)message sureTitle:(NSString *)sureTitle {
    ALERTVIEW_HIGHT = 125;
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    CGFloat h = [message boundingRectWithSize:CGSizeMake(ALERTVIEW_WIDTH - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName: font} context:nil].size.height;
    ALERTVIEW_HIGHT = ALERTVIEW_HIGHT + h;
    
    CGFloat x = (APP_SCREEN_WIDTH - ALERTVIEW_WIDTH)/2;
    CGFloat y = (APP_SCREEN_HEIGHT - ALERTVIEW_HIGHT)/2;
    self.frame = [[UIScreen mainScreen] bounds];
    [self addSubview:self.markView];
    [self addSubview:self.alertView];
    [self.alertView setFrame:CGRectMake(x, y, ALERTVIEW_WIDTH, ALERTVIEW_HIGHT)];
    self.lbTitle.text = title;
    [self.lbTitle setFrame:CGRectMake(0, 24, ALERTVIEW_WIDTH, 21)];
    [self.alertView addSubview:self.lbTitle];
    
    
    [self.btSure setTitle:sureTitle forState:UIControlStateNormal];
    [self.btSure setFrame:CGRectMake(0, ALERTVIEW_HIGHT - ALERTVIEW_BUTTON_HIGHT, ALERTVIEW_WIDTH , ALERTVIEW_BUTTON_HIGHT)];
    [self.alertView addSubview:self.btSure];
    
    self.lbMessage.text = message;
    [self.lbMessage setFrame:CGRectMake(15, 45 + 12, ALERTVIEW_WIDTH - 30, h)];
    [self.alertView addSubview:self.lbMessage];
    
    [self.alertView addSubview:[self drawHorizontalLineWithY:(ALERTVIEW_HIGHT - ALERTVIEW_BUTTON_HIGHT)]];
     [APP_WINDOW addSubview:self];
}

- (void)showAlertViewTitle:(NSString *)title
                   Message:(NSString *)message
               cancleTitle:(NSString *)cancleTitle
                 sureTitle:(NSString *)sureTitle {
    ALERTVIEW_HIGHT = 125;
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    CGFloat h = [message boundingRectWithSize:CGSizeMake(ALERTVIEW_WIDTH - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName: font} context:nil].size.height;
    ALERTVIEW_HIGHT = ALERTVIEW_HIGHT + h;
    
    CGFloat x = (APP_SCREEN_WIDTH - ALERTVIEW_WIDTH)/2;
    CGFloat y = (APP_SCREEN_HEIGHT - ALERTVIEW_HIGHT)/2;
    self.frame = [[UIScreen mainScreen] bounds];
    [self addSubview:self.markView];
    [self addSubview:self.alertView];
    [self.alertView setFrame:CGRectMake(x, y, ALERTVIEW_WIDTH, ALERTVIEW_HIGHT)];
    self.lbTitle.text = title;
    [self.lbTitle setFrame:CGRectMake(0, 24, ALERTVIEW_WIDTH, 21)];
    [self.alertView addSubview:self.lbTitle];
    
    
    [self.btCancle setTitle:cancleTitle forState:UIControlStateNormal];
    [self.btCancle setFrame:CGRectMake(0, ALERTVIEW_HIGHT - ALERTVIEW_BUTTON_HIGHT, ALERTVIEW_WIDTH / 2, ALERTVIEW_BUTTON_HIGHT)];
    [self.alertView addSubview:self.btCancle];
    
    
    [self.btSure setTitle:sureTitle forState:UIControlStateNormal];
    [self.btSure setFrame:CGRectMake(ALERTVIEW_WIDTH/2, ALERTVIEW_HIGHT - ALERTVIEW_BUTTON_HIGHT, ALERTVIEW_WIDTH / 2, ALERTVIEW_BUTTON_HIGHT)];
    [self.alertView addSubview:self.btSure];
    
    self.lbMessage.text = message;
    [self.lbMessage setFrame:CGRectMake(15, 45 + 12, ALERTVIEW_WIDTH - 30, h)];
    [self.alertView addSubview:self.lbMessage];
    
    [self.alertView addSubview:[self drawHorizontalLineWithY:(ALERTVIEW_HIGHT - ALERTVIEW_BUTTON_HIGHT)]];
    [self.alertView addSubview:[self drawVerticalLineWithX:(ALERTVIEW_WIDTH /2)]];
    [APP_WINDOW addSubview:self];
}

#pragma mark - button action
- (void)tappedbtSure:(UIButton *)sender {
    if (self.sureBlcok) {
        self.sureBlcok(sender);
    }
    [self cleanAlertView];
}

- (void)tappedCancelButton:(UIButton *)sender {
    if (self.cancleBlcok) {
        self.cancleBlcok(sender);
    }
    [self cleanAlertView];
}
#pragma mark - config

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.alertView.backgroundColor = Color_R_G_B_A(255, 255, 255, 1);
    self.markView.alpha = 0.5;
    self.lbMessage.textColor = Color_R_G_B_A(51, 51, 51,1);
    self.lbTitle.backgroundColor = Color_R_G_B_A(255, 255, 255,1);
    self.btCancle.backgroundColor = Color_R_G_B_A(255, 255, 255,1);
    self.btSure.backgroundColor = Color_R_G_B_A(255, 255, 255,1);
}

//line ->水平
- (UIView *)drawHorizontalLineWithY:(CGFloat)y {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, ALERTVIEW_WIDTH, 0.5)];
    [line setBackgroundColor:Color_R_G_B_A(221, 221, 221,1)];
    return line;
}
//line ->垂直
- (UIView *)drawVerticalLineWithX:(CGFloat)x {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, ALERTVIEW_HIGHT - 50, 0.5, 50)];
    [line setBackgroundColor:Color_R_G_B_A(221, 221, 221,1)];
    return line;
}
#pragma mark - lazyload
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius = 2;
        _alertView.clipsToBounds = YES;
    }
    return _alertView;
}

- (UIView *)markView {
    if (!_markView) {
        _markView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _markView.backgroundColor = Color_R_G_B_A(0, 0, 0,0);
    }
    return _markView;
}

- (UILabel *)lbMessage {
    if (!_lbMessage) {
        _lbMessage = [[UILabel alloc] init];
        _lbMessage.font = pingFangSCRegular(14);
        _lbMessage.numberOfLines = 0;
        _lbMessage.layer.cornerRadius = 3;
        _lbMessage.clipsToBounds = YES;
        _lbMessage.text = @"详细信息";
        _lbMessage.textAlignment = NSTextAlignmentCenter;
    }
    return _lbMessage;
}

- (UILabel *)lbTitle {
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = pingFangSCMedium(16);
        _lbTitle.textColor = Color_R_G_B_A(51, 51, 51,1);
        _lbTitle.text = @"标题";
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.numberOfLines = 0;
    }
    return _lbTitle;
}

- (UIButton *)btCancle {
    if (!_btCancle) {
        _btCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btCancle setTitleColor:Color_R_G_B_A(153, 153, 153, 1) forState:UIControlStateNormal];
        _btCancle.titleLabel.font = pingFangSCRegular(18);
        [_btCancle addTarget:self action:@selector(tappedCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btCancle;
}

- (UIButton *)btSure {
    if (!_btSure) {
        _btSure = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btSure setTitleColor:Color_R_G_B_A(80, 140, 238, 1) forState:UIControlStateNormal];
        _btSure.titleLabel.font = pingFangSCRegular(18);
        [_btSure addTarget:self action:@selector(tappedbtSure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btSure;
}

@end
