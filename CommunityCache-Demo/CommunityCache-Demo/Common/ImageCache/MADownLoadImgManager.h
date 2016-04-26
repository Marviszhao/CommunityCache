//
//  MADownLoadImgManager.h
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MADownLoadImgManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *imgCacheDic;
@property (nonatomic, strong) NSOperationQueue    *queue;

+(id)shareManager;

//防止程序没有关闭并且持续不断的下载将会把内存填满，此方法用于清空内存占用。
-(void)clearImgCatchs;

//1.内存中查找图片
-(UIImage*)searchImgWithUrlString:(NSString*)urlStr;

//2.本地查找，找到后加载到内存
-(UIImage*)searchImgInLocalWithString:(NSString*)urlStr;

//3.下载数据，下载完成后一方面加载到内存，另一方面缓存到本地
-(void)downLoadImgWithString:(NSString *)urlStr toImgView:(UIImageView*)imgView;

@end
