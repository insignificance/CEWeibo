//
//  CEBottomView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/22.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEBottomView.h"
#import "CEStatues.h"

@interface CEBottomView ()

/*底部工具条高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfToolBar;
/*转发按钮*/
@property (weak, nonatomic) IBOutlet UIButton *reweekBtn;
/*评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
/*点赞按钮*/
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;



@end


@implementation CEBottomView

- (void)setStatues:(CEStatues *)statues{
    
    
    _statues = statues;
    
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





@end
