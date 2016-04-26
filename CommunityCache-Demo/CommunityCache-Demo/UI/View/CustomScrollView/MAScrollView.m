//
//  MAScrollView.m
//  MAScrollView
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAScrollView.h"
#import "MAImageView.h"
#import "UIImageView+WebCache.h"


typedef NS_ENUM(NSUInteger, CAROUSEL_TYPE) {
    CAROUSEL_TYPE_NENE = 0,       //暂未设置
    CAROUSEL_TYPE_LOCAL_IMG ,    //本地图片轮播
    CAROUSEL_TYPE_NETWORK_IMG,   //网络图片轮播
};
#define SCROLL_WIDTH  self.bounds.size.width     //banner的宽度
#define SCROLL_HEIGHT  self.bounds.size.height   //banner的高度

@interface MAScrollView ()<UIScrollViewDelegate,MAImageViewDelegate>
/**
 *  左侧imageView
 */
@property (nonatomic, strong) MAImageView *leftImgView;
/**
 *  中间正在显示的imageView
 */
@property (nonatomic, strong) MAImageView *centerImgView;
/**
 *  右侧imageView
 */
@property (nonatomic, strong) MAImageView *rightImgView;
/**
 *  控制image自动轮播定时器
 */
@property (nonatomic, strong) NSTimer *scrollTimer;
/**
 *  控制timer的轮播时间间隔，默认为3秒
 */
@property (nonatomic, assign) NSTimeInterval changeImgTime;
/**
 *  当前显示图片的下标，默认默认从1开始
 */
@property (nonatomic, assign) NSUInteger currentImgNum;
/**
 *  图片轮播类型
 */
@property (nonatomic, assign) CAROUSEL_TYPE carouserType;
@end

@implementation MAScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(SCROLL_WIDTH, 0);
        self.contentSize = CGSizeMake(SCROLL_WIDTH * 3, SCROLL_HEIGHT);
        self.delegate = self;
        self.changeImgTime = 3.0f;
        self.currentImgNum = 0;
        self.showPageControl = YES;
        self.carouserType = CAROUSEL_TYPE_NENE;
        
        self.leftImgView = [[MAImageView alloc]initWithFrame:CGRectMake(0, 0, SCROLL_WIDTH, SCROLL_HEIGHT)];
        _leftImgView.delegate = self;
        [self addSubview:_leftImgView];
        self.centerImgView = [[MAImageView alloc]initWithFrame:CGRectMake(SCROLL_WIDTH, 0, SCROLL_WIDTH, SCROLL_HEIGHT)];
        _centerImgView.delegate = self;
        [self addSubview:_centerImgView];
        self.rightImgView = [[MAImageView alloc]initWithFrame:CGRectMake(SCROLL_WIDTH*2, 0, SCROLL_WIDTH, SCROLL_HEIGHT)];
        _rightImgView.delegate = self;
        [self addSubview:_rightImgView];
        
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_changeImgTime target:self selector:@selector(animalChangeImage) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc {
    //释放timer
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
    if (![self.superview isEqual:self.pageControl.superview]) {
        [[self superview] addSubview:_pageControl];
    }
}

- (void)animalChangeImage{
    [self setContentOffset:CGPointMake(SCROLL_WIDTH * 2, 0) animated:YES];
}

- (void)stopTimer:(BOOL)yesOrNo{
    if (yesOrNo) {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
    } else {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
    }
}

#pragma mark -  SET METHODS
#pragma mark
- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isAutoScroll = isAutoScroll;
    if (isAutoScroll) {
         [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
    } else {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
    }
    if ([self.imgUrlsArray count] == 1 || [self.imgNameArray count] == 1) {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
    }
    
}

- (void)setImgUrlsArray:(NSArray *)imgUrlsArray{
    if ([_imgUrlsArray isEqual:imgUrlsArray]) {
        return;
    }
    _imgUrlsArray = [imgUrlsArray copy];
    NSUInteger count = [imgUrlsArray count];
    self.pageControl.numberOfPages = count;
    self.carouserType = CAROUSEL_TYPE_NETWORK_IMG;
    if (count == 1) {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
        self.scrollEnabled = NO;
        [_centerImgView getImgWithUrlString:_imgUrlsArray.firstObject];
        return;
    }
    if (count == 2) {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
        self.scrollEnabled = YES;
        [_leftImgView getImgWithUrlString:_imgUrlsArray.lastObject];
        [_centerImgView getImgWithUrlString:_imgUrlsArray.firstObject];
        [_rightImgView getImgWithUrlString:_imgUrlsArray.lastObject];
    }
    if (count >= 3) {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
        self.scrollEnabled = YES;
        [_leftImgView getImgWithUrlString:_imgUrlsArray.lastObject];
        [_centerImgView getImgWithUrlString:_imgUrlsArray.firstObject];
        [_rightImgView getImgWithUrlString:_imgUrlsArray[2]];
    }
}

- (void)setImgNameArray:(NSArray *)imgNameArray{
    if ([_imgNameArray isEqual:imgNameArray]) {
        return;
    }
    _imgNameArray = [imgNameArray copy];
    NSUInteger count = [imgNameArray count];
    self.pageControl.numberOfPages = count;
    self.carouserType = CAROUSEL_TYPE_LOCAL_IMG;
    if (count == 1) {
        [self.scrollTimer setFireDate:[NSDate distantFuture]];
        self.scrollEnabled = NO;
        _centerImgView.image = [UIImage imageNamed:_imgNameArray.firstObject];
        return;
    }
    if (count == 2) {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
        self.scrollEnabled = YES;
        _leftImgView.image = [UIImage imageNamed:_imgNameArray.lastObject];
        _centerImgView.image = [UIImage imageNamed:_imgNameArray.firstObject];
        _rightImgView.image = [UIImage imageNamed:_imgNameArray.lastObject];
    }
    if (count >= 3) {
        [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
        self.scrollEnabled = YES;
        _leftImgView.image = [UIImage imageNamed:_imgNameArray.lastObject];
        _centerImgView.image = [UIImage imageNamed:_imgNameArray.firstObject];
        _rightImgView.image = [UIImage imageNamed:_imgNameArray[1]];
    }
}

- (void)setPageControlStyle:(MAPageControlLayoutStyle)pageControlStyle{
    _pageControlStyle = pageControlStyle;
    if (pageControlStyle == MAPageControlLayoutStyleNone) {
        return;
    }
    CGFloat position_y = CGRectGetMinY(self.frame);
    if (pageControlStyle == MAPageControlLayoutStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, position_y + SCROLL_HEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    } else if (pageControlStyle == MAPageControlLayoutStyleCenter){
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(SCROLL_WIDTH/2.0, position_y+SCROLL_HEIGHT - 10);
        
    } else if (pageControlStyle == MAPageControlLayoutStyleCenter){
        _pageControl.frame = CGRectMake( SCROLL_WIDTH - 20*_pageControl.numberOfPages, position_y+SCROLL_HEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
}

-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    if (self.pageControl) {//pageControl 存在则直接设置pageControl是否显示
        [self.pageControl setHidden:!showPageControl];
        return;
    }
    //pageControl 不存在显示的时候在创建
    if (showPageControl) {
        _pageControl = [[UIPageControl alloc]init];
        [self setPageControlStyle:MAPageControlLayoutStyleCenter];
    }
}


#pragma mark - 图片停止时,调用该函数使得滚动视图复用
#pragma mark
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.scrollTimer setFireDate:[NSDate distantFuture]];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_changeImgTime]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self resetScrollViewUIAndOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self resetScrollViewUIAndOffset];
}

- (void)resetScrollViewUIAndOffset{
    if (!_imgNameArray && !_imgUrlsArray) {//防止没有设置数据源导致的崩溃，
        return;
    }
    NSUInteger count = 0;
    if (self.carouserType == CAROUSEL_TYPE_LOCAL_IMG) {
        count = _imgNameArray.count;
    } else if (self.carouserType == CAROUSEL_TYPE_NETWORK_IMG){
        count = _imgUrlsArray.count;
    }
    if (self.contentOffset.x == 0) { //scrollView 向左边滑动了
        if (_currentImgNum == 0) {//防止数据越界
            _currentImgNum = count - 1;
        } else {
            _currentImgNum = (_currentImgNum-1) % count;
        }
    } else if(self.contentOffset.x == SCROLL_WIDTH * 2) {//scrollView 向右边滑动了
        _currentImgNum = (_currentImgNum+1) % count;
    } else {
        //因为每次滚动结束后 都重设了ScrollView的contentOffset 为中间的那个imageView开始的位置，因此没有其他情况
    }
    _pageControl.currentPage = _currentImgNum;
    
    if (self.carouserType == CAROUSEL_TYPE_LOCAL_IMG) {
        if (_currentImgNum == 0) {
            _leftImgView.image = [UIImage imageNamed:_imgNameArray.lastObject];
        } else {
            _leftImgView.image = [UIImage imageNamed:_imgNameArray[(_currentImgNum-1) % count]];
        }
        
        _centerImgView.image = [UIImage imageNamed:_imgNameArray[_currentImgNum % count]];
        
        _rightImgView.image = [UIImage imageNamed:_imgNameArray[(_currentImgNum+1) % count]];
        
    } else if (self.carouserType == CAROUSEL_TYPE_NETWORK_IMG){
        if (_currentImgNum == 0) {
            [_leftImgView getImgWithUrlString:_imgUrlsArray.lastObject];
        } else {
            [_leftImgView getImgWithUrlString:_imgUrlsArray[(_currentImgNum-1) % count]];
        }
        [_centerImgView getImgWithUrlString:_imgUrlsArray[_currentImgNum % count]];
        [_rightImgView getImgWithUrlString:_imgUrlsArray[(_currentImgNum+1) % count]];
    }
        
    
    self.contentOffset = CGPointMake(SCROLL_WIDTH, 0);
    
    if ([_MADelegate respondsToSelector:@selector(MAScrollView:didScrollToADIndes:)]) {
        [_MADelegate MAScrollView:self didScrollToADIndes:_currentImgNum];
    }
}
#pragma mark - MAImageViewDelegate
#pragma mark
- (void)didTouchMAImageView:(MAImageView *)imgView{
    if ([_MADelegate respondsToSelector:@selector(MAScrollView:userTapADIndes:)]) {
        [_MADelegate MAScrollView:self userTapADIndes:_currentImgNum];
    }
}


@end
