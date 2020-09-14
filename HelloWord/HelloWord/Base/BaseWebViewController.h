//
//  BaseWebViewController.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : UIViewController
@property (nonatomic, strong) WKWebView * WKWeb;
@property (nonatomic, strong) WKWebViewConfiguration * wkConfiguration;
@property (nonatomic, strong) WKUserContentController * wkUserContentController;
@property (nonatomic, strong, readonly) NSURL * loadURL;
@property (nonatomic, strong) NSString *loadURLString;
@end

NS_ASSUME_NONNULL_END
