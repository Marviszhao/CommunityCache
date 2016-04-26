//
//  MAImageView.h
//  MAScrollView
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAImageView;

@protocol MAImageViewDelegate <NSObject>

- (void)didTouchMAImageView:(MAImageView *)imgView;

@end

@interface MAImageView : UIImageView

@property (nonatomic, assign) id<MAImageViewDelegate> delegate;

@end
