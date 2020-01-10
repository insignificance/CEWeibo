//
//  CEViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/9.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEViewController.h"
#import "CETabBar2.h"
#import "CEHomeViewController.h"
#import "CEMessageViewController.h"
#import "CEProfileViewController.h"
#import "CEDiscoverViewController.h"
#import "CENavigationController.h"



@interface CEViewController ()<CETabBar2Delegate>

@property (nonatomic,weak)CETabBar2 *customTabBar;

@end

@implementation CEViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //替换系统TableBar
    
    
    //系统tableBar 只读
    //self.tabBar = [[CETabBar alloc]init];
    
    //采用kvc 运行时动态改变属性值

    //CETabBar *tabBar = [[CETabBar alloc]init];
    
    //[self setValue:tabBar forKeyPath:@"tabBar"];
    

    
  
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

    
}




-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    //移除系统自带的tabBar
    
    [self.tabBar removeFromSuperview];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark -
#pragma mark -- 重写指定初始化方法

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        //DDLogDebug(@"%d %s", __LINE__ , __func__);
         
        //设置子控制器
        
        [self setUpChildVC];
        
      
    }
    
   
    
    return self;
}


#pragma mark -
#pragma mark -- 初始化子控制器


- (void)setUpChildVC {
    
    
    
    UIViewController *home = [self addViewControllerWithClass:[CENavigationController class] withObj: [CEHomeViewController new] image:@"tabbar_home" selectedImage:@"tabbar_home_selected" andTitile:@"首页"];
    
    UIViewController *message = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEMessageViewController new]  image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected" andTitile:@"消息"];
    
    UIViewController *discover = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEDiscoverViewController new]  image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected" andTitile:@"发现"];
    
    
    UIViewController *profile = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEProfileViewController new]  image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected" andTitile:@"我"];
 
    
    
    
    self.viewControllers = @[home,message,discover,profile];
    
    
    
    
    
    
    
}







#pragma mark -
#pragma mark -- 懒加载自定义TabBar


- (CETabBar2 *)customTabBar{
    
    
    if (_customTabBar == nil) {
        
        CETabBar2 *tabBar = [[CETabBar2 alloc]initWithFrame:self.tabBar.frame];
        
        //成为代理对象
        tabBar.delegate = self;
        
        self.customTabBar = tabBar;
        
        [self.view addSubview:tabBar];
        
        //移除系统自带UITabBar //注意ios10 以后 写在这里是不行 的 系统在设置layout时会重新添加 tabBar
        
        // [self.tabBar removeFromSuperview];
        
        //解决方案 1. 隐藏
        
        //self.tabBar.hidden = YES;
        
        //解决方案 2. 在viewDidAppear:、viewDidLayoutSubviews 中移除
        
        
        
    }
    
    return _customTabBar;
    
}







#pragma mark -
#pragma mark -- 根据给定的类初始化对应vc 注意Class 是个类




/// Description 获取自定义vc
/// @param Class 控制器对应的类
/// @param obj 其它参数
/// @param image 默认状态图片
/// @param selectImg 选中状态图片
/// @param title 标题

- (UIViewController *)addViewControllerWithClass:(Class )Class withObj:(NSObject *)obj image:(NSString *)image selectedImage: (NSString *)selectImg andTitile:(NSString *)title{
    
    
    UIViewController *vc = nil;
    
    
    //如果Class 是UINavigationController 
    if ([[Class new] isKindOfClass:[CENavigationController class]]) {
        
        
        UIViewController *rootVC = (UIViewController *)obj;
        vc = [[CENavigationController alloc]initWithRootViewController:rootVC];
        
        //设置导航条文字
        //rootVC.title = title;
        rootVC.navigationItem.title = title;
        
     
    }else{
        
        
        vc = [[Class alloc]init];
        
    }
    
   
    [self addViewControllerWithVc:vc image:image selectedImage:selectImg andTitile:title];

    return vc;
    
}



#pragma mark -
#pragma mark -- 根据给定vc初始化控制器

/// 获取自定义vc
/// @param vc 控制器
/// @param image 默认图片
/// @param selectImg 选中图片
/// @param title 标题
- (UIViewController *)addViewControllerWithVc:(UIViewController *)vc image:(NSString *)image selectedImage: (NSString *)selectImg andTitile:(NSString *)title{
    
    
    
    //设置随机色
    vc.view.backgroundColor = CERandomColor;
    

    
    //改变图片的渲染模式
      
    UIImage *realImg  = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = realImg;
    
    //改变选中图片的渲染模式
    
    UIImage *realselImg = [[UIImage imageNamed:selectImg]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = realselImg;
    vc.tabBarItem.title = title;
    
     //设置tabBarButton的标题颜色
        //设置文字的属性有一个规律:NSXXXXXAttributeName
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    
   //为自定义Tabar 添加 按钮 
    [self.customTabBar addItemFromBarItem:vc.tabBarItem];
    
    

    
    return vc;
    
}


#pragma mark -
#pragma mark -- 实现CETabBar2 代理方法


- (void)CETabBar2:(CETabBar2 *)tabBar withCEItem:(CEItem *)item from:(NSInteger)from to:(NSInteger)to{
    
    
    
    [self setSelectedIndex:to];
    
    
    
}



@end
