//
//  CEHomeCell.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/21.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEHomeCell.h"
#import "CEStatues.h"
#import "CEUser.h"
#import "CEPhoto.h"

#define margin 10

@interface CEHomeCell ()

/*原创微博区域的高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfsection1;

@property (nonatomic,weak)IBOutlet UIImageView *iconImageView;
@property (nonatomic,weak)IBOutlet UILabel *nameLabel;
@property (nonatomic,weak)IBOutlet UIImageView *vipImageView;
@property (nonatomic,weak)IBOutlet UILabel *timeLabel;
@property (nonatomic,weak)IBOutlet UILabel *sourceLabel;
@property (nonatomic,weak)IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;




@end


@implementation CEHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置原创微博正文最大宽度
    
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setStatues:(CEStatues *)statues{
    
    _statues = statues;
    
    CEUser *user = statues.user;
    //头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"compose_trendbutton_background"]];
    //昵称
    self.nameLabel.text = user.name;
    //vip
    if ([_statues.user isVip]) {
        //是会员
        //显示会员
        self.vipImageView.hidden = NO;
        
        //设置会员图标
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",[_statues.user.mbrank intValue] % 6 + 1]; //[1,6]
        DDLogDebug(@"%@",imageName);
        
        self.vipImageView.image = [UIImage imageNamed:imageName];
         
        //设置会员昵称颜色
        [self.nameLabel setTextColor:[UIColor orangeColor]];
        
        
        
    }else{
        
        //非会员
        //隐藏会员
        self.vipImageView.hidden = YES;
        //设置非会员昵称颜色
        [self.nameLabel setTextColor:[UIColor blackColor]];
        
        
    }
    
    //认证图标
    
    /**
     
        typedef enum {
            
            IWUserVerifiedTypeNone = -1, // 没有任何认证
            
            //  黄V
            IWUserVerifiedPersonal = 0,  // 个人认证
            
            // 蓝V
            IWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
            IWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
            IWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
            
            // 红色行星
            IWUserVerifiedDaren = 220 // 微博达人
            
        } CEUserVerifiedType;
     
     
     */
    
    self.typeImageView.hidden = NO;
    
    switch (_statues.user.verified_type) {
            
        case IWUserVerifiedPersonal:
            self.typeImageView.image  = [UIImage imageNamed:@"avatar_vip"];
            break;
        case IWUserVerifiedOrgEnterprice:
        case IWUserVerifiedOrgMedia:
        case IWUserVerifiedOrgWebsite:
            self.typeImageView.image  = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case IWUserVerifiedDaren:
            self.typeImageView.image  = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            //没有认证
            self.typeImageView.hidden = YES;
        break;
    }

    //时间
    
    [self.timeLabel setTextColor: [UIColor grayColor]];
    self.timeLabel.text = _statues.created_at;
    
    //来源
    
    self.sourceLabel.text = _statues.source;

    //正文
        
    self.contentLabel.text = _statues.text;
    
    //原创微博区域高度 = 正文的y + 正文的高
    //1. 计算紧凑状态下 正文的高度
    CGFloat contentLabelHeight = [self.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    self.heightOfsection1.constant = self.contentLabel.mj_y + contentLabelHeight;
    
    
    
}



- (CGFloat)cellHeightWithStatus:(CEStatues *)statues{
    
    //重新计算高度
    self.statues = statues;

    //计算高度并返回
    
    return self.heightOfsection1.constant + margin;
    
    
    
}



@end
