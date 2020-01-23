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
#import "CEStatusOriginalView.h"
#import "CEStatusRetweetedView.h"
#import "CEBottomView.h"




@interface CEHomeCell ()

/*原创微博*/
@property (weak, nonatomic) IBOutlet CEStatusOriginalView *statusOriginalView;
/*=================================================================*/
/*转发微博*/
@property (weak, nonatomic) IBOutlet CEStatusRetweetedView *statusRetweetedView;
/*==================================================================================*/
/*底部视图*/
@property (weak, nonatomic) IBOutlet CEBottomView *bottomView;

@end


@implementation CEHomeCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




#pragma mark -
#pragma mark -- 数据布局

- (void)setStatues:(CEStatues *)statues{
    
    _statues = statues;
    
    //[self layoutIfNeeded];
    
    // 传递数据给原创/转发/底部视图
    self.statusOriginalView.statues = statues;
    self.statusRetweetedView.statues = statues.retweeted_status;
    self.bottomView.statues = statues;
    

    
    
}



#pragma mark -
#pragma mark -- 返回cell 实际高度

- (CGFloat)cellHeightWithStatus:(CEStatues *)statues{
    
    //重新计算高度
    self.statues = statues;
    
    
    //调用layoutIfNeeded 会从当前控件开始更新所有的自控件和自己frame
    [self layoutIfNeeded];
    
    
//    CGFloat cellHeight = 0;
    
    
//   CEStatues *retweektedStatus = statues.retweeted_status;
    
    
//    if (retweektedStatus != nil) {
//        //有转发 = 转发y + 转发高 + 间隙
//        //cellHeight = self.heightOfSection1.constant + self.heightOfSection2.constant + self.heightOfToolBar.constant + 2*margin;
//
//
//    }else{
//
//        cellHeight = self.heightOfSection1.constant + self.heightOfToolBar.constant + 2*margin;
//
//    }
//
//
//    //计算高度并返回
//
//    return cellHeight;
    
    
    return CGRectGetMaxY(self.bottomView.frame) + margin;
    
    
    
    
    
    
}








@end
