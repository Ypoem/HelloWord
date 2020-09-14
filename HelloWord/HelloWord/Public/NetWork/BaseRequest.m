//
//  BaseRequest.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
#import "GlobleFile.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface BaseRequest()
@property (copy, nonatomic) NSString *host;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) MBProgressHUD *loadingHud;
@end

@implementation BaseRequest
+ (BaseRequest *)shared {
    static dispatch_once_t onceToken;
    static BaseRequest *shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[BaseRequest alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.host = @"https://openapi-centretest4.bicai365.com";
        self.manager =[AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 70;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        [self.manager.securityPolicy setValidatesDomainName:NO];
        self.manager.securityPolicy.allowInvalidCertificates = YES;

    }
    return self;
}

- (void)httpRequest:(NSString *)url params:(NSDictionary *)params refreshData:(refreshBlcok)refreshData failure:(void (^)(NSError * error))failureBlock {
     
//     __block HTTPResponseObject *object = [[HTTPResponseObject alloc] init];
    NSString *fullUrl = [NSString stringWithFormat:@"%@/%@", _host, url];
    NSDictionary *headParams = @{
        @"head": [self header],
        @"param": params
    };
     
     NSLog(@"URL:%@, %@", fullUrl, headParams);
     [self showNetLoadingHud];
     WEAK_SELF;

    [self.manager POST:fullUrl parameters:headParams progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        STRONG_SELF;
        NSLog(@"%@", responseObject);
//        object.code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        object.data = (NSDictionary *)responseObject[@"data"];
//        object.responseTime = [NSString stringWithFormat:@"%@",responseObject[@"responseTime"]];
//        object.msg = [NSString stringWithFormat:@"%@", responseObject[@"msg"]];
//        object.responseDate = [NSString stringWithFormat:@"%@", responseObject[@"responseDate"]];
//        object.result = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        [strongSelf.loadingHud hideAnimated:YES];
//        @try {
//            if (object.code.intValue != 0) { //请求错误
//                 refreshData(object, NetworkDataStateError);
//                 return;
//             } else if (object.code.intValue == 0 && object.data == nil ) { //请求成功.data无数据
//                 refreshData(object, NetworkDataStateDataEmpty);
//                 return;
//             } else if (object.code.intValue == 0 && object.data != nil ) { //请求成功.data有数据
//                 refreshData(object, NetworkDataStateOk);
//                 return;
//             }
//        } @catch (NSException * excep) {
//
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { //网络请求失败
        STRONG_SELF;
        [strongSelf showNetErrorProgressHud];
        failureBlock(error);
    }];
}

- (void)showNetErrorProgressHud {
    UIView *myContainer = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:myContainer animated:YES];
    UIImageView *cusView = [[UIImageView alloc] init];
    [cusView setImage:[UIImage imageNamed:@"wifiDisable"]];
    hud.customView = cusView;
    [hud.label setText:@"网络不给力\n请稍后再试"];
    [hud.label setNumberOfLines:3];
    [hud.label setFont:pingFangSCRegular(14)];
    [hud.label setTextColor:Color_R_G_B_A(96, 98, 102, 1)];
    [hud.bezelView setColor:Color_R_G_B_A(232, 235, 237, 0.7)];
    [hud.bezelView.layer setCornerRadius:12];
    [hud.bezelView setBlurEffectStyle:UIBlurEffectStyleLight];
    hud.minSize = CGSizeMake(126, 132);
    hud.mode = MBProgressHUDModeCustomView;
    hud.offset = CGPointMake(0, -60);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)showNetLoadingHud {
    UIView *myContainer = [UIApplication sharedApplication].delegate.window;
    self.loadingHud= [MBProgressHUD showHUDAddedTo:myContainer animated:YES];
}

- (NSDictionary *)header {
    return @{};
}

- (MBProgressHUD *)loadingHud {
    if (!_loadingHud) {
        _loadingHud = [[MBProgressHUD alloc] init];
        _loadingHud.mode = MBProgressHUDModeDeterminate;
        _loadingHud.label.text = @"加载中";
        _loadingHud.removeFromSuperViewOnHide = YES;
    }
    return _loadingHud;
}
@end

@implementation UIImageView (HudImageView)
- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeTop;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(36, 36 + 16);
}
@end

