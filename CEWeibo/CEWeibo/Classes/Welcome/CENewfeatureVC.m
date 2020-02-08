//
//  CENewfeatureVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CENewfeatureVC.h"
#import "CETabBarController.h"

@interface CENewfeatureVC ()

@end

@implementation CENewfeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ClickEnterBtn:(UIButton *)sender {
    
    CETabBarController *tabBarVc = [[CETabBarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    
    
    
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
