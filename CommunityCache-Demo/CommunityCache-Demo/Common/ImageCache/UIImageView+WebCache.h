//
//  UIImageView+WebCache.h
//  OperationDLImg-test-me
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

-(void)getImgWithUrlString:(NSString*)urlStr;
-(void)getImgWithUrlString:(NSString *)urlStr placeHolder:(UIImage *)aImage;
@end
