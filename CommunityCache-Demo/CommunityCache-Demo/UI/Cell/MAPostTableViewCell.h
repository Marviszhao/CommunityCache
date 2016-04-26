//
//  TableViewCell.h
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPostModel.h"


@interface MAPostTableViewCell : UITableViewCell

+ (UINib *)nib;;

- (void)resetCellContentWithModel:(MAPostModel *)postModel;

@end
