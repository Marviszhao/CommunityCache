//
//  MAScrollLoadMoreView.h
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LoadMoreState) {
    kLoadStateDefault,
    kLoadStateLoading,
    kLoadStateFinished,
    kLoadStateFailed,
    kLoadStateNoMore,
};

@interface MAScrollLoadMoreView : UIView
@property (nonatomic, assign, readonly) LoadMoreState currentState;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) NSString *loadMoreText;
@property (nonatomic, strong) NSString *loadingText;
@property (nonatomic, strong) NSString *finishedText;
@property (nonatomic, strong) NSString *failedText;
@property (nonatomic, strong) NSString *noMoreText;

- (void)updateState:(LoadMoreState)state;
@end
