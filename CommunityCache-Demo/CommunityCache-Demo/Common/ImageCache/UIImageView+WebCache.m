//
//  UIImageView+WebCache.m
//  OperationDLImg-test-me
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "MADownLoadImgManager.h"


@implementation UIImageView (WebCache)

-(void)getImgWithUrlString:(NSString*)urlStr
{
    //1 从内存中读取图片
    MADownLoadImgManager *manager = [MADownLoadImgManager shareManager];
    UIImage *img = [manager.imgCacheDic objectForKey:urlStr];
    if (img) {
        self.image = img;
        return;
    }
    //2 从本地中读取图片，并加载到缓存。
    img = [manager searchImgInLocalWithString:urlStr];
    if (img) {
        self.image = img;
        [manager.imgCacheDic setObject:img forKey:urlStr];
        return;
    }
        
    //3 从网上下载，下载完成后一方面加载到内存，另一方面缓存到本地
    [manager downLoadImgWithString:urlStr toImgView:self];
    
}

-(void)getImgWithUrlString:(NSString *)urlStr placeHolder:(UIImage *)aImage
{
    self.image = aImage;
    [self getImgWithUrlString:urlStr];
}

@end
