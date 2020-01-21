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
#import "CEColPhotoCell.h"

#define margin 10


static NSString *reuseID = @"photoCell";

@interface CEHomeCell ()<UICollectionViewDataSource>

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

/*=================================================================*/

/*转发微博正文*/
@property (weak, nonatomic) IBOutlet UILabel *reweetedContentLabel;

/*转发微博容器高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfSection2;

/*转发微博容器*/
@property (weak, nonatomic) IBOutlet UIView *reweetedView;

/*转发配图容器高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedPhotoViewHeight;

/*转发微博配图容器*/
@property (weak, nonatomic) IBOutlet UICollectionView *retweetedphotoCollectionView;

/*标记是否存在转发*/
@property (nonatomic,assign,getter=isRetweeted) BOOL retweeted;

/*==================================================================================*/

/*底部工具条高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfToolBar;
/*转发按钮*/
@property (weak, nonatomic) IBOutlet UIButton *reweekBtn;
/*评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
/*点赞按钮*/
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;



@end


@implementation CEHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置原创微博正文最大宽度
    
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    self.reweetedContentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




#pragma mark -
#pragma mark -- 数据布局

- (void)setStatues:(CEStatues *)statues{
    
    _statues = statues;
    
    //[self layoutIfNeeded];
    
   
    
    
    //1. 原创微博
    
    [self setUpOriginalStatus:statues];

    
    //2. 转发微博
    
    if (statues.retweeted_status != nil) {
        
        //标记是否是转发
        self.retweeted = YES;
        
        //显示
        self.reweetedView.hidden = NO;
        
        [self setUpRetweetedStatus:statues];
    }else{
        
        
        self.retweeted = NO;
        
        //隐藏
        self.reweetedView.hidden = YES;
        self.heightOfSection2.constant = 0;
        
        
    }
    
    
    //3. 设置底部视图
    
    /*
     如果小于10000 直接显示数字
     如果大于10000 显示x.y万
     如果大于10000并且可以被10000整除 显示x 万
     
     */
    
    
    NSUInteger repostsCount = _statues.reposts_count;
    
    NSUInteger commitCount = _statues.comments_count;
    
    NSUInteger likeCount  = _statues.attitudes_count;
    
    
   // DDLogDebug(@"repostsCount :%lu repostsCount:%lu likeCount::%lu",repostsCount,commitCount,likeCount);
    
    
    
    [self setBtn:self.reweekBtn count:repostsCount withNama:@"转发"];
    
    [self setBtn:self.commitBtn count:commitCount withNama:@"评论"];
    
    [self setBtn:self.likeBtn count:likeCount withNama:@"赞"];
    
    
    
    
    
    
      
    
    
    
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
      if ([_statues.user isVip]) {
          //是会员
          //显示会员
          self.vipImageView.hidden = NO;
          
          //设置会员图标
          NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",[_statues.user.mbrank intValue] % 6 + 1]; //[1,6]
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
      
      self.heightOfSection1.constant = self.contentLabel.mj_y + contentLabelHeight;
      
      
      //设置配图
      NSUInteger count = _statues.pic_urls.count;
      
      
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


#pragma mark -
#pragma mark -- 设置转发微博


- (void)setUpRetweetedStatus:(CEStatues *)statues{
    
    
    CEStatues *retweeyedStatus = statues.retweeted_status;
    
    
    //1. 设置转发正文
    self.reweetedContentLabel.text = [NSString stringWithFormat:@"@%@\n: %@",retweeyedStatus.user.name,retweeyedStatus.text];
    
    //2. 计算转发微博的高度
    
    //  计算紧凑状态下 正文的高度
    CGFloat contentLabelHeight = [self.reweetedContentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    
    self.heightOfSection2.constant = self.reweetedContentLabel.mj_y + contentLabelHeight + margin;
    
    
    //设置配图
         NSUInteger count = retweeyedStatus.pic_urls.count;
         
         
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
             self.retweetedPhotoViewHeight.constant = photosHeight;
             
             //让collectionview 重新加载数据
             
             [self.retweetedphotoCollectionView reloadData];
             
         //修改原创微博的高度 = 原来的高度 + 配图管理器的高度 + margin
             
             self.heightOfSection2.constant +=photosHeight + margin;
             
         }else{
             //没有配图
             self.heightOfSection2.constant = 0;
             
         }
    
    
    
    
    
    
    
    
}



- (CGFloat)cellHeightWithStatus:(CEStatues *)statues{
    
    //重新计算高度
    self.statues = statues;
    
    CGFloat cellHeight = 0;
    
    
    CEStatues *retweektedStatus = statues.retweeted_status;
    
    
    if (retweektedStatus != nil) {
        
        cellHeight = self.heightOfSection1.constant + self.heightOfSection2.constant + self.heightOfToolBar.constant + 2*margin;
        
    }else{
        
        cellHeight = self.heightOfSection1.constant + self.heightOfToolBar.constant + 2*margin;
        
    }
    
    
    //计算高度并返回
    
    return cellHeight;
    
    
    
}


#pragma mark -
#pragma mark -- 设置工具条


- (void)setBtn:(UIButton *)btn count:(NSUInteger) count withNama:(NSString *)name{
    
    
    
    NSString *title = nil;
       
       if (count > 0) {
           //有
           title = [NSString stringWithFormat:@"%lu",count];
           
           if (count > 10000) {
               
               double number = count/10000.0;
               title = [NSString stringWithFormat:@"%.1f 万",number];
               
               //将.0 的情况去除
               
               title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
  
           }

           
           [btn setTitle:title forState:UIControlStateNormal];
           [btn setTitle:title forState:UIControlStateHighlighted];
       }else{
           //没有
           
           [btn setTitle:name forState:UIControlStateNormal];
           [btn setTitle:name forState:UIControlStateHighlighted];
           
           
           
       }
    
    
}




#pragma mark -
#pragma mark -- UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    NSInteger count = 0;
    
    if (self.isRetweeted) {
        //是转发
        
        count = self.statues.retweeted_status.pic_urls.count;
        
        
    }else{
        //不是
        count = self.statues.pic_urls.count;
        
    }
    
    
    return count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取cell
    
    CEColPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];

    //设置数据
    
    CEPhoto *photo = nil;
    
    if (self.isRetweeted) {
        
        //转发
        photo = self.statues.retweeted_status.pic_urls[indexPath.row];
        cell.photo = photo;
        
    }else{
        //不是转发
        photo = self.statues.pic_urls[indexPath.row];
        
         
    }

    cell.photo = photo;
    
    //返回
    return cell;
    
    
    
    
}

@end
