//
//  MAScrollLoadMoreView.m
//  CommunityCache-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAScrollLoadMoreView.h"
@interface MAScrollLoadMoreView ()
@property (nonatomic, strong) UIButton *loadMoreButton;
@property (nonatomic, strong) UILabel *loadMoreLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end


@implementation MAScrollLoadMoreView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self setupDefualtText];
    
    self.loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 20, 7)];
    _loadMoreLabel.backgroundColor = [UIColor clearColor];
    _loadMoreLabel.textAlignment = NSTextAlignmentCenter;
    _loadMoreLabel.font = [UIFont systemFontOfSize:14];
    _loadMoreLabel.textColor = [UIColor grayColor];
    _loadMoreLabel.text = _loadMoreText;
    
    [self addSubview:_loadMoreLabel];
    self.loadMoreButton = [[UIButton alloc] initWithFrame:_loadMoreLabel.frame];
    [self addSubview:_loadMoreButton];
    
    self.indicator =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = _indicator.frame;
    frame.origin =
    CGPointMake(50, (CGRectGetHeight(self.bounds) - CGRectGetHeight(_indicator.frame))*.5f );
    _indicator.frame = frame;
    [self addSubview:_indicator];
    
}

- (void)setupDefualtText {
    self.loadMoreText = @"加载更多";
    self.loadingText = @"加载中...";
    self.finishedText = @""; //@"加载完成";
    self.failedText = @""; //@"加载失败";
    self.noMoreText = @"没有更多";
}

- (void)updateState:(LoadMoreState)state {
    if (state == _currentState) {
        return;
    }
    NSString *textStr;
    BOOL needAnimate = NO;
    switch (state) {
        case kLoadStateDefault:
            textStr = _loadMoreText;
            break;
        case kLoadStateLoading:
            needAnimate = YES;
            textStr = _loadingText;
            break;
        case kLoadStateFinished:
            textStr = _finishedText;
            break;
        case kLoadStateFailed:
            textStr = _failedText;
            break;
        case kLoadStateNoMore:
            textStr = _noMoreText;
            break;
        default:
            break;
    }
    
    _loadMoreLabel.text = textStr;
    if (needAnimate) {
        if (![_indicator isAnimating]) {
            [_indicator startAnimating];
        }
    }
    else {
        if ([_indicator isAnimating]) {
            [_indicator stopAnimating];
        }
    }
    
    _currentState = state;
    
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _loadMoreLabel.textColor = textColor;
}

- (void)setLoadMoreText:(NSString *)loadMoreText {
    _loadMoreText = loadMoreText;
    _loadMoreLabel.text = loadMoreText;
}


@end
