//
//  MAImageView.m
//  MAScrollView
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAImageView.h"
//扩展使用
typedef NS_ENUM(NSUInteger, TITLE_SHOW_STYLE) {
    TITLE_SHOW_STYLE_NONE = 0,
    TITLE_SHOW_STYLE_LEFT,
    TITLE_SHOW_STYLE_CENTER,//default
    TITLE_SHOW_STYLE_RIGHT,
};

@interface MAImageView ()
@property (nonatomic, copy) NSString *ADTitle;

@property (nonatomic, assign) TITLE_SHOW_STYLE showStyle;

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation MAImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapedGestureRecognizer:)];
        [tapGesture setNumberOfTapsRequired:1];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setADTitle:(NSString *)ADTitle{
    
}

- (void)userTapedGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer{
    if ([_delegate respondsToSelector:@selector(didTouchMAImageView:)]) {
        [_delegate didTouchMAImageView:self];
    }
}

@end
