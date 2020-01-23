//
//  CEStatusRetweetedView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/22.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatusRetweetedView.h"
#import "CEStatues.h"
#import "CEPhoto.h"
#import "CEColPhotoCell.h"

static NSString *reuseID = @"photoCell";
@interface CEStatusRetweetedView ()

/*转发微博正文*/
@property (weak, nonatomic) IBOutlet UILabel *reweetedContentLabel;

/*转发微博容器高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfSection2;

/*转发配图容器高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedPhotoViewHeight;

/*转发微博配图容器*/
@property (weak, nonatomic) IBOutlet UICollectionView *retweetedphotoCollectionView;


@end

@implementation CEStatusRetweetedView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.reweetedContentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    
}

- (void)setStatues:(CEStatues *)statues{
    
    
    //_statues = statues; 父类私有
    
    [super setStatues:statues];
    
    
    //2. 转发微博
       
       if (statues.retweeted_status != nil) {
           //显示
           self.hidden = NO;
           
           [self setUpRetweetedStatus:statues];
       }else{
           
           //隐藏
           self.hidden = YES;
           self.heightOfSection2.constant = 0;
           
           
       }
    
    
     
    
}
#pragma mark -
#pragma mark -- 设置转发微博


- (void)setUpRetweetedStatus:(CEStatues *)statues{
    
    
    CEStatues *retweeyedStatus = statues;
    
    
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
             
         //重新计算转发微博的高度 = 原来的高度 + 配图管理器的高度 + margin
             
             self.heightOfSection2.constant +=photosHeight + margin;

             
             
         }else{
             //没有配图
            
            
             self.retweetedPhotoViewHeight.constant = 0;
            
             
         }

    
    
    
    
    
    
}


@end
