//
//  CEStatusOriginalView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/22.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatusOriginalView.h"
#import "CEStatues.h"
#import "CEPhoto.h"
#import "CEColPhotoCell.h"
#import <GKPhotoBrowser/GKPhotoBrowser.h>


static NSString *reuseID = @"photoCell";
@interface CEStatusOriginalView ()

/*原创微博区域的高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfSection1;

/*配图容器的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;

/*配图管理容器*/
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;


@property (nonatomic,weak)IBOutlet UIImageView *iconImageView;
@property (nonatomic,weak)IBOutlet UILabel *nameLabel;
@property (nonatomic,weak)IBOutlet UIImageView *vipImageView;
@property (nonatomic,weak)IBOutlet UILabel *timeLabel;
@property (nonatomic,weak)IBOutlet UILabel *sourceLabel;
@property (nonatomic,weak)IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;


@end


@implementation CEStatusOriginalView




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置原创微博正文最大宽度
    
    [super awakeFromNib];
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    
}


- (void)setStatues:(CEStatues *)statues{
    
    
    //_statues = statues; f父类私有
    
    [super setStatues:statues];

    //1. 原创微博
    
    [self setUpOriginalStatus:statues];

    
    
}

#pragma mark -
#pragma mark -- 设置原创微博

- (void)setUpOriginalStatus:(CEStatues *)statues{
    
    
    
    CEUser *user = statues.user;
    //头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"compose_trendbutton_background"]];
    //昵称
    self.nameLabel.text = user.name;
    //vip
    if ([self.statues.user isVip]) {
        //是会员
        //显示会员
        self.vipImageView.hidden = NO;
        
        //设置会员图标
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",[self.statues.user.mbrank intValue] % 6 + 1]; //[1,6]
        //DDLogDebug(@"%@",imageName);
        
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
    
    switch (self.statues.user.verified_type) {
            
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
    self.timeLabel.text = self.statues.created_at;
    
    //来源
    
    self.sourceLabel.text = self.statues.source;
    
    //正文
    
    self.contentLabel.text = self.statues.text;
    
    //原创微博区域高度 = 正文的y + 正文的高
    //1. 计算紧凑状态下 正文的高度
    CGFloat contentLabelHeight = [self.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    self.heightOfSection1.constant = self.contentLabel.mj_y + contentLabelHeight;
    
    
    //设置配图
    NSUInteger count = self.statues.pic_urls.count;
    
    
    if (count > 0) {
        //有配图
        //1. 计算几行
        
        NSUInteger row = 0;
        
        if (count % 3 == 0) {
            
            row = count / 3;
            
        }else{
            
            
            row = count /3 + 1;
            
            
        }
        
        CGFloat photoHeight = 70;
        CGFloat photoMargin = 10;
        //2. 计算高度
        //行数 * 配图高度 + （行数 - 1）* 间隙
        
        CGFloat photosHeight = row * photoHeight + (row -1) *photoMargin;
        //3.设置配图管理器的高度
        self.photoViewHeight.constant = photosHeight;
        
        //让collectionview 重新加载数据
        
        [self.photoCollectionView reloadData];
        
        //修改原创微博的高度 = 原来的高度 + 配图管理器的高度 + margin
        
        self.heightOfSection1.constant +=photosHeight + margin;
        
    }else{
        //没有配图
        self.photoViewHeight.constant = 0;
        
    }
    
    
    
    
}






@end
