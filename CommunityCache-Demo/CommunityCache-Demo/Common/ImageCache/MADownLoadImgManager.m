//
//  MADownLoadImgManager.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MADownLoadImgManager.h"
#import "NSString+Addtions.h"
#import "MAOperation.h"

static MADownLoadImgManager *manager = nil;

@implementation MADownLoadImgManager

+(id)shareManager
{
    @synchronized(self){
        if (manager == nil) {
            manager = [[self alloc] init];
            NSLog(@"come into shareManager method");
        }
    }
    return manager;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (manager == nil) {
            manager = [super allocWithZone:zone];
            NSLog(@"come into allocWithZone method");
        }
        return manager;
    }
    return nil;
}

-(void)clearImgCatchs{
    [self.imgCacheDic removeAllObjects];
}

-(id)init
{
    self = [super init];
    if (self) {
        self.imgCacheDic = [[NSMutableDictionary alloc] init] ;
        self.queue = [[NSOperationQueue alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearImgCatchs) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [self.imgCacheDic removeAllObjects];
}

#pragma mark - DownLoad

//1.内存中查找图片
-(UIImage*)searchImgWithUrlString:(NSString*)urlStr
{
    UIImage *image = [self.imgCacheDic objectForKey:urlStr];
    return image;
}

//2.本地查找，找到后加载到内存
-(UIImage*)searchImgInLocalWithString:(NSString*)urlStr
{
    NSString *path = [NSString getFilePathWithDirectory:@"Documents/imgcaches" fileName:[urlStr md5WithString]];
    NSData *data = [NSData dataWithContentsOfMappedFile:path];
    UIImage *img = [UIImage imageWithData:data];
    return img;
}

//3.下载数据，下载完成后一方面加载到内存，另一方面缓存到本地
-(void)downLoadImgWithString:(NSString *)urlStr toImgView:(UIImageView*)imgView
{
    MAOperation *operation = [MAOperation downLoadWithUrlStr:urlStr toImageView:imgView];
    [self.queue addOperation:operation];
    [self.queue setMaxConcurrentOperationCount:5];
}


@end
