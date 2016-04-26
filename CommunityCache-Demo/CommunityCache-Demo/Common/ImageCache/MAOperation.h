//
//  MAOperation.h
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MAOperation : NSOperation

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, weak) UIImageView *imgview;

-(instancetype)initWithUrlString:(NSString*)urlStr toImageView:(UIImageView*)imgView;
+(instancetype)downLoadWithUrlStr:(NSString*)urlStr toImageView:(UIImageView*)imgView;

@end
