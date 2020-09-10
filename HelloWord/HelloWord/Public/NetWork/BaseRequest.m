//
//  BaseRequest.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
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
@end
