//
//  PostFileManager.h
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAPostFileManager : NSObject
/**
 *  保存广告banner数据
 *
 *  @param jsonData 服务器返回的jsonData数据
 */
+ (void )saveBannerDataWithJsonData:(NSData *)jsonData;
/**
 *  获取广告banner数据
 *
 *  @return banner的图片远程的URL数组
 */
+ (NSArray *)getSavedBannerData;
/**
 *  保存社区列表页数据
 *
 *  @param jsonData 服务器返回的jsonData数据
 */
+ (void )saveDataWithJsonData:(NSData *)jsonData;
/**
 *  获取保存在本地的文件的数据
 *
 *  @param pageNum 查询的页码
 *
 *  @return PostModel Array
 */
+ (NSArray *)getSavedPlistDataArratWithPage:(NSUInteger)pageNum;
/**
 *  删除本地缓存的文件
 */
+ (void)celarSaveedFile;

@end
