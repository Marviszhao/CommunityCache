//
//  MAParseHelper.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAParseHelper.h"
#import "MAPostBannerModel.h"
#import "MAPostModel.h"

#define kNotNullProperty(property)          ![(property) isKindOfClass:[NSNull class]]
#define kStrProperty(property)              kNotNullProperty(property) && [property length] > 0
#define kIntProperty(property)              kNotNullProperty(property) && [property integerValue] >= 0
#define kFloatProperty(property)            kNotNullProperty(property) && [property floatValue] >= 0
#define kUintProperty(property)             kNotNullProperty(property) && [property intValue] > 0
#define kArrayProperty(property)            [(property) isKindOfClass:[NSArray class]]
#define kDictProperty(property)             [(property) isKindOfClass:[NSDictionary class]]
#define kErrorProperty(property)            ![(property) isKindOfClass:[NSError class]]

@implementation MAParseHelper

+ (NSArray *)parserBannerDicToArray:(NSDictionary *)bannerDic{
    if ([[bannerDic allKeys] count] == 0) {
        return nil;
    }
    NSArray *bannerArr = bannerDic[@"bannerList"];
    NSMutableArray *bannerUrlArr = [NSMutableArray array];
    if (kArrayProperty(bannerArr)) {
        for (NSDictionary *dic in bannerArr) {
            if (kDictProperty(dic)) {
//                NSNumber *bannerType = dic[@"bannerType"];
//                NSString *bannerCallbackUrl = dic[@"bannerCallbackUrl"];
                NSString *bannerImgUrl = dic[@"bannerImgUrl"];
//                MAPostBannerModel *bannerModel = [[MAPostBannerModel alloc] init];
//                if (kIntProperty(bannerType))   bannerModel.bannerType = [bannerType integerValue];
//                if (kStrProperty(bannerCallbackUrl)) bannerModel.bannerCallbackUrl = bannerCallbackUrl;
//                if (kStrProperty(bannerImgUrl)) bannerModel.bannerImgUrl = bannerImgUrl;
                if (kStrProperty(bannerImgUrl)){
                    [bannerUrlArr addObject:bannerImgUrl];
                }
            }
        }
    }
    
    return [bannerUrlArr copy];
}

+ (NSArray *)parserPostListDicToArray:(NSDictionary *)bannerDic{
    if ([[bannerDic allKeys] count] == 0) {
        return nil;
    }
    NSArray *postArr = bannerDic[@"postList"];
    NSMutableArray *postModelArr = [NSMutableArray array];
    if (kArrayProperty(postArr)) {
        for (NSDictionary *dic in postArr) {
            if (kDictProperty(dic)) {
                NSNumber *postProfit         = dic[@"postProfit"];
                NSNumber *postPageViews      = dic[@"postPageViews"];
                NSString *postPublisher      = dic[@"postPublisher"];
                NSNumber *postType           = dic[@"postType"];
                NSString *postImgUrl         = dic[@"postImgUrl"];
                NSString *postRemainTimeStr  = dic[@"postRemainTimeStr"];
                NSString *postTitle          = dic[@"postTitle"];
                NSString *postTimeStr        = dic[@"postTimeStr"];
                NSNumber *postAttentionCount = dic[@"postAttentionCount"];
                
                MAPostModel *postModel = [[MAPostModel alloc] init];
                if (kFloatProperty(postProfit))   postModel.postProfit = [postProfit floatValue];
                if (kIntProperty(postPageViews))   postModel.postPageViews = [postPageViews integerValue];
                if (kStrProperty(postPublisher)) postModel.postPublisher = postPublisher;
                if (kIntProperty(postType))   postModel.postType = [postType integerValue];
                if (kStrProperty(postImgUrl)) postModel.postImgUrl = postImgUrl;
                if (kStrProperty(postRemainTimeStr)) postModel.postRemainTimeStr = postRemainTimeStr;
                if (kStrProperty(postTitle)) postModel.postTitle = postTitle;
                if (kStrProperty(postTimeStr)) postModel.postTimeStr = postTimeStr;
                if (kIntProperty(postAttentionCount))   postModel.postAttentionCount = [postAttentionCount integerValue];
                
                [postModelArr addObject:postModel];
            }
        }
    }
    
    return [postModelArr copy];
}

@end
