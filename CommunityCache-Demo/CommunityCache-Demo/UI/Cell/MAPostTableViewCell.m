//
//  TableViewCell.m
//  PostsCell-Demo
//
//  Created by imac on 16/4/5.
//  Copyright © 2016年 kingdee. All rights reserved.
//

#import "MAPostTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface MAPostTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *postImgView;

@property (nonatomic, weak) IBOutlet UILabel *postTitleLab;

@property (nonatomic, weak) IBOutlet UILabel *postProfitLab;

@property (nonatomic, weak) IBOutlet UILabel *postAttentionCountLab;

@property (nonatomic, weak) IBOutlet UILabel *postRemainTimeLab;


@end

@implementation MAPostTableViewCell

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)resetCellContentWithModel:(MAPostModel *)postModel{
    [self.postImgView getImgWithUrlString:postModel.postImgUrl placeHolder:[UIImage imageNamed:@"ph_sm_marketcom_03"]];
    self.postTitleLab.text = [[postModel.postTitle componentsSeparatedByString:@"]"] lastObject];
    
    NSString *gradeStr = [NSString stringWithFormat:@"%.2f%%",postModel.postProfit];
    NSString *text = [NSString stringWithFormat:@"%@年收益率 |",gradeStr];
    NSRange range = [text rangeOfString:gradeStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:range];
    
    self.postProfitLab.attributedText = attributedStr;
    self.postAttentionCountLab.text = [NSString stringWithFormat:@" %ld人已关注 |",(long)postModel.postAttentionCount];
    self.postRemainTimeLab.text = postModel.postRemainTimeStr;
}


@end
