//
//  CEViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/9.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CETabBarController.h"
#import "CETabBar2.h"
#import "CEHomeViewController.h"
#import "CEMessageViewController.h"
#import "CEProfileViewController.h"
#import "CEDiscoverViewController.h"
#import "CENavigationController.h"
#import "CEComposeVC.h"
#import "CEUnreadCountModel.h"

//模拟小红点
static NSInteger badgeValue = 0;
@interface CETabBarController ()<CETabBar2Delegate>

@property (nonatomic,weak)CETabBar2 *customTabBar;

@property (nonatomic,strong)UINavigationController *homeNavViewControlle;
@property (nonatomic,strong)UINavigationController *messageNavViewController;
@property (nonatomic,strong)UINavigationController *profileNavViewController;
@property (nonatomic,strong)UINavigationController *discoverNavViewController;



@end

@implementation CETabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //替换系统TableBar
    
    
    //系统tableBar 只读
    //self.tabBar = [[CETabBar alloc]init];
    
    //采用kvc 运行时动态改变属性值

    //CETabBar *tabBar = [[CETabBar alloc]init];
    
    //[self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    //5 . 开启定时器 获取为读信息
     CEAccount *account = [CEAccountTool accountFromSandbox];
    
    //若已经有账号
    if (account) {

        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(getUnread:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
       }
    
    
    
    
    
    
  
    
}

#pragma mark -
#pragma mark -- 获取未读数


- (void)getUnread:(NSTimer *)timer{
    
    
    //CEAccount *account = [timer userInfo];
    
   // AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    
   // parameters[@"access_token"] = account.access_token;
    //parameters[@"uid"] = account.uid;
    
   // NSString *urlString = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    
    //DDLogDebug(@"self.homeViewControlle = %@",self.homeViewControlle);
    
    
    [[CENetWorkingTools shareNetworkTools] loadUnreadCount:^(CEUnreadCountModel * _Nonnull unreadModel) {
        
        badgeValue = [unreadModel.status intValue];
        
        self.homeNavViewControlle.tabBarItem.badgeValue  = [NSString stringWithFormat:@"%ld",badgeValue];
        [UIApplication sharedApplication].applicationIconBadgeNumber = badgeValue;
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        DDLogDebug(@"%@",error);
        
        
    }];
    
    
//    badgeValue += 2;
//
//    self.homeNavViewControlle.tabBarItem.badgeValue  = [NSString stringWithFormat:@"%ld",badgeValue];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeValue;
    
    
//    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//
//
//        //设置tabbarbutton badgevalue 小红点提醒
//        //DDLogDebug(@"responseObjc = %@",responseObject);
//        NSNumber *number = responseObject[@"status"];
//
//        if (number.intValue > 0) {
//            //有未读消息
//            DDLogDebug(@"有未读消息");
//
//            self.homeViewControlle.tabBarItem.badgeValue = [number description];
//
//            //设置应用图标上的提醒
//
//           [UIApplication sharedApplication].applicationIconBadgeNumber = number.integerValue;
//
//
//        }
//
//
//
//
//
//
//
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        DDLogDebug(@"error = %@",error);
//
//
//    }];
//
    
    
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

    
}




-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    //移除系统自带的tabBar
    
    //[self.tabBar removeFromSuperview];
    //NSLog(@"subViews = %@",[self.tabBar subviews]);
    
    //删除系统自带的tabbar 中不需要的其它控件
    
    for (UIView *childView in self.tabBar.subviews) {
        
        
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [childView removeFromSuperview];
        
            
        }
        
        
        
    }
    
    
    
    
    
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
    
    
    /*
    UIViewController *home = [self addViewControllerWithClass:[CENavigationController class] withObj: [CEHomeViewController new] image:@"tabbar_home" selectedImage:@"tabbar_home_selected" andTitile:@"首页"];
    
    UIViewController *message = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEMessageViewController new]  image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected" andTitile:@"消息"];
    
    UIViewController *discover = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEDiscoverViewController new]  image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected" andTitile:@"发现"];
    
    
    UIViewController *profile = [self addViewControllerWithClass:[CENavigationController class]withObj: [CEProfileViewController new]  image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected" andTitile:@"我"];
     */
    
    
    UINavigationController *homeNav = (UINavigationController *)[self addViewControllerWithSbName:NSStringFromClass([CEHomeViewController class])  image:@"tabbar_home" selectedImage:@"tabbar_home_selected" andTitile:@"首页"];

    
    self.homeNavViewControlle = homeNav;
    
    //self.homeViewControlle  = (CEHomeViewController *)homeNav.topViewController;
    
    
     UINavigationController *messageNav = (UINavigationController *)[self addViewControllerWithSbName:NSStringFromClass([CEMessageViewController class]) image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected" andTitile:@"消息"];
    
    //self.messageViewController = (CEMessageViewController *)messageNav.topViewController;
    
    self.messageNavViewController = messageNav;

     UINavigationController *discoverNav = (UINavigationController *)[self addViewControllerWithSbName:NSStringFromClass([CEDiscoverViewController class])image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected" andTitile:@"发现"];
    
    //self.discoverViewController  = (CEDiscoverViewController *)discoverNav.topViewController;
    
    self.discoverNavViewController = discoverNav;
     
     UINavigationController *profileNav = (UINavigationController *)[self addViewControllerWithSbName:NSStringFromClass([CEProfileViewController class])image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected" andTitile:@"我"];
    
    //self.profileViewController = (CEProfileViewController *)profileNav.topViewController;
        
    self.profileNavViewController = profileNav;
    
    self.viewControllers = @[homeNav,messageNav,discoverNav,profileNav];
    
    
    
    
    
    
    
}







#pragma mark -
#pragma mark -- 懒加载自定义TabBar


- (CETabBar2 *)customTabBar{
    
    
    if (_customTabBar == nil) {
        
        CETabBar2 *tabBar = [[CETabBar2 alloc]initWithFrame:self.tabBar.bounds];
        
        //成为代理对象
        tabBar.delegate = self;
        
        self.customTabBar = tabBar;
        
        //[self.view addSubview:tabBar];
        
        //将自定义tabbar 添加到系统的tabbar上
        [self.tabBar addSubview:tabBar];
        
        
        
        //移除系统自带UITabBar //注意ios10 以后 写在这里是不行 的 系统在设置layout时会重新添加 tabBar
        
        // [self.tabBar removeFromSuperview];
        
        //解决方案 1. 隐藏
        
        //self.tabBar.hidden = YES;
        
        //解决方案 2. 在viewDidAppear:、viewDidLayoutSubviews 中移除
        
        
        
    }
    
    return _customTabBar;
    
}




#pragma mark -
#pragma mark -- 根据指定的storyboard 初始化对应的vc



/// Description 获取自定义vc
/// @param name storyBoardName
/// @param image tabBarButton item 图片
/// @param selectImg 选中图片
/// @param title 标题
- (UIViewController *)addViewControllerWithSbName:(NSString *)name image:(NSString *)image selectedImage: (NSString *)selectImg andTitile:(NSString *)title{
    
    
   
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
     
    CEDefaultCenterVC *rootVC = [sb instantiateInitialViewController];
    
    CENavigationController *nav = [[CENavigationController alloc]initWithRootViewController:rootVC];
    
    rootVC.navigationItem.title = title;
    
    [self addViewControllerWithVc:nav image:image selectedImage:selectImg andTitile:title];

    return nav;
    
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
    
    UINavigationController *nav = self.childViewControllers[to];
    
    UIViewController *vc = [nav topViewController];
    
    
    if ([vc isKindOfClass:[CEHomeViewController class]]) {
        //点击的是首页
        CEHomeViewController *tableViewVC = (CEHomeViewController *)vc;
        
        //判断是否是当前控制器界面点击
        
        if (from == 0 && to == 0) {
            
            
            if (self.homeNavViewControlle.tabBarItem.badgeValue.intValue >0 ) {
                //存在数据
                
                [tableViewVC.tableView.mj_header beginRefreshing];
                DDLogDebug(@"下拉刷新");
                
                //清除小红点
                self.homeNavViewControlle.tabBarItem.badgeValue = @"0";
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                
                
                
            }else{
                //不存在数据 滑动到顶部
                
               
                DDLogDebug(@"滚动到顶部");
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                
                [tableViewVC.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                
                
                
            }
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
}


- (void)CETabBar2:(CETabBar2 *)tabBar selectedAddbtn:(UIButton *)addBtn{
    
    
    //创建发送界面
     //CEComposeVC *compVC  = [[CEComposeVC alloc]init];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CEComposeStoryboard"bundle:nil];
    
    CEComposeVC *compVC = [sb instantiateInitialViewController];
    

     CENavigationController *nav = [[CENavigationController alloc]initWithRootViewController:compVC];
    
        
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    
    //弹出发送界面
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}



@end
