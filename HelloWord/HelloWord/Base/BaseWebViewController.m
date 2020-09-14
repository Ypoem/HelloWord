//
//  BaseWebViewController.m
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import "BaseWebViewController.h"
#import "GlobleFile.h"
@interface BaseWebViewController ()
@property (nonatomic, strong, readwrite) NSURL * loadURL;
@property (nonatomic, strong) UIProgressView * WKProgessView;
@end

@implementation BaseWebViewController

- (void)initWebView {
    [self.WKWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.WKWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)closeViewController {
    if ([self.WKWeb canGoBack]) {
        [self.WKWeb goBack];
    } else {
//        [super closeViewController];
    }
}
- (UIProgressView *)WKProgessView {
    if (!_WKProgessView) {
        _WKProgessView = [[UIProgressView alloc] init];
//        _WKProgessView.frame = [self getBarFrame];
        _WKProgessView.trackTintColor = [UIColor clearColor];
        _WKProgessView.progressTintColor = RGBColorString(@"22bc08") ;
        _WKProgessView.hidden = YES;
    }
    return _WKProgessView;
}
- (WKWebViewConfiguration *)wkConfiguration {
    if (!_wkConfiguration) {
        _wkConfiguration = [[WKWebViewConfiguration alloc] init];
        _wkConfiguration.allowsInlineMediaPlayback = true;
    }
    return _wkConfiguration;
}

- (WKUserContentController *)wkUserContentController {
    if (!_wkUserContentController) {
        _wkUserContentController = [[WKUserContentController alloc] init];
    }
    return _wkUserContentController;
}


- (void)loadWebViewWithURL:(NSString *)loadURL loadHTMLString:(NSString *)HTMLString {
    [self initWebView];

    if (loadURL.length) {
        //加载网址
        NSURLRequest * request = [NSURLRequest requestWithURL: [NSURL URLWithString:loadURL]];
        self.loadURL = [NSURL URLWithString:loadURL];
        [self.WKWeb loadRequest:request];
//        [self showLoading];
    } else if (HTMLString.length) {
        //加载HTML代码
        self.loadURL = nil;
        [self.WKWeb loadHTMLString:HTMLString baseURL:[[NSBundle mainBundle] resourceURL]];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential * credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
         }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}
- (void)dealloc {
    [_WKWeb removeObserver:self forKeyPath:@"title"];
    [_WKWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
