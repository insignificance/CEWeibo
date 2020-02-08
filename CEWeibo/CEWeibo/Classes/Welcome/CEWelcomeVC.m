//
//  CEWelcomeVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEWelcomeVC.h"
#import <SDWebImage.h>
#import "CEAccount.h"
#import "CEAccountTool.h"
#import "CETabBarController.h"
#import "UIImage+Extension.h"

@interface CEWelcomeVC ()
@property (weak, nonatomic) IBOutlet UILabel *welcomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintY;

@end

@implementation CEWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //1. 设置圆角
    
//    self.icon.layer.cornerRadius = 50;
//    self.icon.layer.masksToBounds = YES;
//
    
    //下载头像
    
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    NSURL *url = [NSURL URLWithString:account.avatar_large];
    
    
    //若不为空
    if (url) {
        
        //[self.icon sd_setImageWithURL:url];
        
        [self.icon sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
           
            
            UIImage *newImage = [image circleImageWithBorderWidth:2 borderColor:[UIColor orangeColor]];
            
            
            self.icon.image = newImage;
            
            
        }];
        
        
        
    }
    
    
    
    
    
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    [UIView animateWithDuration:2.0 animations:^{
        
        
        //修改头像位置
        
        self.iconConstraintY.constant = -[UIScreen mainScreen].bounds.size.height *0.3;
        self.icon.alpha = 1.0;
        [self.view layoutIfNeeded];
        
    
        
    }completion:^(BOOL finished) {
        
        //让欢迎回来的文字做动画
        
        [UIView animateWithDuration:1.5 animations:^{
            
            
            self.welcomLabel.alpha = 1.0;
            
        }completion:^(BOOL finished) {
            
            CETabBarController *tabBarVc = [[CETabBarController alloc]init];
            
            //切换主窗口
            
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
            
            
        }];
        
        
        
    }];
    
    
    
    
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
