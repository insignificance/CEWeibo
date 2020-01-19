//
//  CENavigationController.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/2.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CENavigationController.h"

@interface CENavigationController ()

@end

@implementation CENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置大字体
       
       //[self.navigationBar setPrefersLargeTitles:YES];
        
    
       //self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    
       
    

    
}



+ (void)initialize{
    
    //设置UIBarButtonItem 的主题
    
    //1.拿到主题对象
    
    UIBarButtonItem *item  = [UIBarButtonItem appearance];
    
    //2. 设置主题
    
    //创建字典保持UIBarButtonItem需要设置的属性
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    md[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    //设置UIBarButtonItem的属性
    
    [item setTitleTextAttributes:md forState:UIControlStateNormal];
    
    //设置不可用状态的主题颜色
    
    NSMutableDictionary *disableMd = [NSMutableDictionary dictionary];
    
    disableMd[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    //设置UIBarButtonItme 的属性
    
    [item setTitleTextAttributes:disableMd forState:UIControlStateDisabled];
    
  
    
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
