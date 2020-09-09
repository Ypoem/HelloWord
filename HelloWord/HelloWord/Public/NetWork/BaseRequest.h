//
//  BaseRequest.h
//  HelloWord
//
//  Created by 张诗雨 on 2020/9/9.
//  Copyright © 2020 openapi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetworkDataState) {
    NetworkDataStateNormal       = 1,
    NetworkDataStateDataEmpty,
    NetworkDataStateNoMoreData,
    NetworkDataStateNetwokError
};

/**
 数据请求完成后的回调block类型

 @param refreshData 返回数据
 @param state 网络数据状态(正常返回, 暂无数据, 没有更多, 网络错误), 详见NetworkDataState枚举
 */
typedef void(^refreshBlcok)(NSDictionary *refreshData, NetworkDataState state);

@interface BaseRequest : NSObject

+ (BaseRequest *)shared;

- (void)httpRequest:(NSString *)url params:(NSDictionary *)params refreshData:(refreshBlcok)refreshData failure:(void (^)(NSError * error))failureBlock;

@end

NS_ASSUME_NONNULL_END
