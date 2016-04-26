//
//  PostModel.h
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MAPostModel : NSObject
//发布宣传图片
@property (nonatomic, copy) NSString *postImgUrl;
//发布标题
@property (nonatomic, copy) NSString *postTitle;
// 0 p2p理财 1 普通理财帖子 2 理财版块  3 随手理财日报
@property (nonatomic, assign) NSUInteger  postType;
//发布者
@property (nonatomic, copy) NSString *postPublisher;
//发布时间
@property (nonatomic, copy) NSString *postTimeStr;
//浏览量
@property (nonatomic, assign) NSInteger postPageViews;
//收益率
@property (nonatomic, assign) double postProfit;

//关注数
@property (nonatomic, assign) NSInteger postAttentionCount;

//活动剩余时间
@property (nonatomic, copy) NSString *postRemainTimeStr;

@end
