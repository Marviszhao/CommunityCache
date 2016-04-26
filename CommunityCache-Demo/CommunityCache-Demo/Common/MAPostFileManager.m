//
//  PostFileManager.m
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAPostFileManager.h"
#import "MAParseHelper.h"

@implementation MAPostFileManager
+ (void )saveBannerDataWithJsonData:(NSData *)jsonData{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [array.firstObject stringByAppendingPathComponent:@"bannerData"];
    BOOL isWriteSuccess =[jsonData writeToFile:docPath atomically:YES];
    NSLog(@"更新本地bannner文件成功---%d",isWriteSuccess);
}

+ (NSArray *)getSavedBannerData{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [array.firstObject stringByAppendingPathComponent:@"bannerData"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docPath]) {
        NSData *jsonData = [NSData dataWithContentsOfFile:docPath];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
        }
        return [MAParseHelper parserBannerDicToArray:dic];
    }
    return nil;
}

+ (void )saveDataWithJsonData:(NSData *)jsonData{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [array.firstObject stringByAppendingPathComponent:@"PostData.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docPath]) {
        NSArray *array = [NSArray arrayWithContentsOfFile:docPath];
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
        [newArray addObject:jsonData];
        BOOL isWriteSuccess = [newArray writeToFile:docPath atomically:YES];
        NSLog(@"更新本地plist文件成功---%d",isWriteSuccess);
    } else {
        NSArray *newArray = @[jsonData];
        BOOL isWriteSuccess = [newArray writeToFile:docPath atomically:YES];
        NSLog(@"写入本地plist文件成功---%d",isWriteSuccess);
    }
}

+ (NSArray *)getSavedPlistDataArratWithPage:(NSUInteger)pageNum{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [array.firstObject stringByAppendingPathComponent:@"PostData.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docPath]) {
        NSArray *array = [NSArray arrayWithContentsOfFile:docPath];
        NSUInteger count = [array count];
        if (pageNum > [array count] - 1) {
            return nil;
        }
        NSData *jsonData = array[count - 1 - pageNum];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
        }
        return [MAParseHelper parserPostListDicToArray:dic];
    }
    return nil;
}

+ (void)celarSaveedFile{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [array.firstObject stringByAppendingPathComponent:@"PostData.plist"];
    NSString* bannerPath = [array.firstObject stringByAppendingPathComponent:@"bannerData"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docPath]) {
        NSError *error = nil;
        BOOL isSucc = [[NSFileManager defaultManager] removeItemAtPath:docPath error:&error];
        if (isSucc) {
            NSLog(@"删除本地缓存plist文件成功");
        } else {
            NSLog(@"删除本地缓存plist文件失败---%@",error);
        }
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:bannerPath]) {
        NSError *error = nil;
        BOOL isSucc = [[NSFileManager defaultManager] removeItemAtPath:bannerPath error:&error];
        if (isSucc) {
            NSLog(@"删除本地缓存banner文件成功");
        } else {
            NSLog(@"删除本地缓存banner文件失败---%@",error);
        }
    }
}

@end
