//
//  MAScrollView.h
//  MAScrollView
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MAPageControlLayoutStyle)
{
    MAPageControlLayoutStyleNone = 0,  //不显示 UIPageControl
    MAPageControlLayoutStyleLeft,      //显示 UIPageControl 在左侧
    MAPageControlLayoutStyleCenter,    //显示 UIPageControl 在中间 default
    MAPageControlLayoutStyleRight,     //显示 UIPageControl 在右侧
};

@class MAScrollView;

@protocol MAScrollViewDelegate <NSObject>
@optional
/**
 *  用户点击了轮播图进行的回调
 *
 *  @param scrollView MAScrollView
 *  @param index      点击的轮播图index
 */
- (void)MAScrollView:(MAScrollView *)scrollView userTapADIndes:(NSUInteger)index;
/**
 *  用户滚动 OR Timer触发的ScrollView更改后index的回调
 *
 *  @param scrollView MAScrollView
 *  @param index      当前轮播图滚动到的index
 */
- (void)MAScrollView:(MAScrollView *)scrollView didScrollToADIndes:(NSUInteger)index;

@end

@interface MAScrollView : UIScrollView

@property (nonatomic, assign) id<MAScrollViewDelegate> MADelegate;
/**
 *  是否显示pageControl
 */
@property (nonatomic, assign) BOOL showPageControl;
/**
 *  是否自动滚动 默认YES
 */
@property (nonatomic, assign) BOOL isAutoScroll;

@property (nonatomic, strong, readonly) UIPageControl *pageControl;
/**
 *   pageControl展示的样式 默认 MAPageControlLayoutStyleNone 
 */
@property (nonatomic, assign) MAPageControlLayoutStyle pageControlStyle;
/**
 *  本地图片轮播数组，不可与网络图片轮播共存
 */
@property (nonatomic, copy) NSArray *imgNameArray;
/**
 *  网络图片轮播数组，不可与本地图片轮播共存
 */
@property (nonatomic, copy) NSArray *imgUrlsArray;
/**
 *  是否暂停timer
 *
 *  @param yesOrNo YES 暂停 NO 开始
 */
- (void)stopTimer:(BOOL)yesOrNo;

@end
