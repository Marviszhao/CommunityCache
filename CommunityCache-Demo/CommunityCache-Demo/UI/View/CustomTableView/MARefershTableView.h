//
//  MARefershTableView.h
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAScrollLoadMoreView.h"
#import "MAScrollViewRefershDelegate.h"

@interface MARefershTableView : UITableView

@property (nonatomic, assign) id<MAScrollViewRefreshDelegate> refreshDelegate;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) MAScrollLoadMoreView *loadMoreView;

- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToBottomAnimated:(BOOL)animated;

- (void)addRefreshControlWithText:(NSString *)text;
- (void)removeRefreshControl;
- (void)endRefreshWithState:(RefreshState)state;

- (void)addLoadMoreFootWithText:(NSString *)text;
- (void)removeLoadMoreFoot;
- (void)startLoadMore;
- (void)endLoadMoreWithState:(LoadMoreState)state;
- (void)resetLoadMoreFoot;

// call |tableViewDidReachFootView| in delegate Method |scrollViewDidScroll:|
- (void)tableViewDidReachFootView;

@end
