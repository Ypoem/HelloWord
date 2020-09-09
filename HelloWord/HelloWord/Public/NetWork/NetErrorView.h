//
//  NetErrorView.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetErrorView : UIView
@property (nonatomic, copy) NSString * emptyMessage;
- (instancetype)initWithFrame:(CGRect)frame state:(NetworkDataState)state retryBlock:(void(^)(id retryView))retryBlock;
@end

NS_ASSUME_NONNULL_END
