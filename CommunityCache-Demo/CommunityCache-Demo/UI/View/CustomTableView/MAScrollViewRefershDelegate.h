//
//  MAScrollViewRefershDelegate.h
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RefreshState) {
    kRefreshStateFinished,
    kRefreshStateFailed,
    kRefreshStateTimeOut,
};

@protocol MAScrollViewRefreshDelegate <NSObject>

@optional
// Top refresh
-(void)startRefreshData:(UIScrollView *)scrollView;
-(void)endRefreshData:(UIScrollView *)scrollView;

// Bottom loadMore
-(void)startLoadMoreData:(UIScrollView *)scrollView;
-(void)endLoadMoreData:(UIScrollView *)scrollView;

@end
