//
//  MAOperation.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAOperation.h"
#import "NSString+Addtions.h"
#import "MADownLoadImgManager.h"

@implementation MAOperation

-(instancetype)initWithUrlString:(NSString*)urlStr toImageView:(UIImageView*)imgView{
    if (self = [super init]) {
        self.urlStr =  urlStr;
        self.imgview = imgView;
    }
    return  self;
}

+(instancetype)downLoadWithUrlStr:(NSString*)urlStr toImageView:(UIImageView*)imgView{
    return [[self alloc] initWithUrlString:urlStr toImageView:imgView];
}

- (void)main{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStr]];
    
    if (data)
    {
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程更新UI
                self.imgview.image = image;
            });
            //存入缓存
            MADownLoadImgManager *manager = [MADownLoadImgManager shareManager];
            [manager.imgCacheDic setObject:image forKey:self.urlStr];
            //存入本地
            NSString *path = [NSString getFilePathWithDirectory:@"Documents/imgCaches" fileName:[self.urlStr md5WithString]];
            [data writeToFile:path atomically:YES];
        }
    }

    
}


@end
