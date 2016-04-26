//
//  MARefershTableView.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MARefershTableView.h"

@implementation MARefershTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.window endEditing:YES];
}

- (void)reloadData{
    [super reloadData];
    CGRect bounds = self.bounds;
    CGSize size = self.contentSize;
    UIEdgeInsets insets = self.contentInset;
    
    if (size.height < bounds.size.height - insets.bottom ||[self.dataSource tableView:self numberOfRowsInSection:0] == 0) {//cell数量少 or 没有数据源，则隐藏loadmoreView
        self.tableFooterView = nil;
    } else {
        self.tableFooterView = _loadMoreView;
    }
}

- (void)scrollToTopAnimated:(BOOL)animated{
    if ([super numberOfSections] > 0) {
        if ([super numberOfRowsInSection:0] > 0) {
            NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
            [super scrollToRowAtIndexPath:indexP
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:animated];
        }
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    
    NSInteger lastSection = [super numberOfSections];
    if (lastSection > 0) {
        lastSection -= 1;
    }
    else {
        return;
    }
    
    NSInteger lastRow = [super numberOfRowsInSection:lastSection];
    if (lastRow > 0) {
        lastRow -= 1;
    }
    else {
        return;
    }
    
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
    
    [super scrollToRowAtIndexPath:indexP
                 atScrollPosition:UITableViewScrollPositionBottom
                         animated:animated];
}

- (void)addRefreshControlWithText:(NSString *)text{
    if (!_refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self
                            action:@selector(handleRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    }
    if ([text length] > 0) {
         _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:text];
    }
    
    if (![_refreshControl superview]) {
        [self addSubview:_refreshControl];
    }
}


- (void)removeRefreshControl{
    if ([_refreshControl superview] && _refreshControl) {
        [_refreshControl removeFromSuperview];
    }
}

- (void)handleRefresh:(id)sender{
    if ([_refreshDelegate respondsToSelector:@selector(startRefreshData:)]) {
        [_refreshDelegate startRefreshData:self];
    }
}

- (void)endRefresh:(id)sender {
    if ([_refreshDelegate respondsToSelector:@selector(endRefreshData:)]) {
        [_refreshDelegate endRefreshData:self];
    }
    
    [self endRefreshWithState:kRefreshStateFailed];
}

- (void)endRefreshWithState:(RefreshState)state{
    if (_refreshControl.refreshing) {
        [_refreshControl endRefreshing];
    }
}

- (void)addLoadMoreFootWithText:(NSString *)text{
    if (!_loadMoreView) {
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44);
        self.loadMoreView = [[MAScrollLoadMoreView alloc] initWithFrame:frame];
        _loadMoreView.textColor = [UIColor grayColor];
        _loadMoreView.loadMoreText = text;
    }
    self.tableFooterView = _loadMoreView;
    [_loadMoreView updateState:kLoadStateDefault];
}

- (void)removeLoadMoreFoot{
    if (self.tableFooterView == _loadMoreView) {
        self.tableFooterView = nil;
    }
}

- (void)startLoadMore{
    if (_loadMoreView.currentState != kLoadStateLoading && _loadMoreView.currentState != kLoadStateNoMore) {
        [_loadMoreView updateState:kLoadStateLoading];
        if ( [_refreshDelegate respondsToSelector:@selector(startLoadMoreData:)]) {
            [_refreshDelegate startLoadMoreData:self];
        }
    }
}

- (void)endLoadMoreWithState:(LoadMoreState)state{
    if (self.tableFooterView) {
        [_loadMoreView updateState:state];
    }
}

- (void)resetLoadMoreFoot {
    if (self.tableFooterView) {
        [_loadMoreView updateState:kLoadStateDefault];
    }
}

- (void)endLoadWithFailed{
    if (self.tableFooterView) {
        [_loadMoreView updateState:kLoadStateFailed];
    }
}

- (void)tableViewDidReachFootView{
    if (self.tableFooterView) {
        CGPoint offset = self.contentOffset;
        CGRect bounds = self.bounds;
        CGSize size = self.contentSize;
        UIEdgeInsets inset = self.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
         NSLog(@"offset: %f", offset.y);
         NSLog(@"content.height: %f", size.height);
         NSLog(@"bounds.height: %f", bounds.size.height);
         NSLog(@"inset.top: %f", inset.top);
         NSLog(@"inset.bottom: %f", inset.bottom);
         NSLog(@"pos: %f of %f", y, h);
        
        float reload_distance = CGRectGetHeight(self.tableFooterView.frame);
        if(y > h ) {
            [self startLoadMore];
        }
    }
}


@end
