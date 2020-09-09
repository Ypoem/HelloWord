//
//  BaseNavigationController.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIViewController * currentShowVC;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    [self.navigationBar setTranslucent:NO];
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//    PinCaiGradientView *view = [[PinCaiGradientView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kTopH)];
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, UIScreen.mainScreen.scale);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: KW_Font_18, NSForegroundColorAttributeName: KW_COLOR_FFFFFF}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
