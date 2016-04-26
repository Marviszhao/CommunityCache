//
//  PostBannerModel.h
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAPostBannerModel : NSObject
/**
 *  广告ID
 */
@property (nonatomic, copy) NSString *bannerID;
/**
 *  banner展示的imageurl
 */
@property (nonatomic, copy) NSString *bannerImgUrl;
/**
 *  点击顶部banner所要请求的网页地址
 */
@property (nonatomic, copy) NSString *bannerCallbackUrl;
/**
 *  banner 所属板块 ：0理财生活 1几张晒单 2 家庭理财 3 新手上路，4理财课堂·····
 */
@property (nonatomic, assign) NSUInteger bannerType;


@end
