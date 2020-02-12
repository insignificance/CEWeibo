//
//  CEProfileViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEProfileViewController.h"
#import "CESettingTableViewController.h"
#import "CEArrowCommonItem.h"
#import "CEGroupCommon.h"

@interface CEProfileViewController ()

@end

@implementation CEProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //设置searchbar
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    
    
    // 设置我界面对应的导航条显示的内容
     UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];

     self.navigationItem.rightBarButtonItem = item;
    
    
    
    // 初始化默认中间视图
    
    [self setUpImgAndTitle];
    
    
    
    // 初始化所有需要显示的数据
       [self setupitems];
       
       // 设置组与组之间的间隙
       self.tableView.sectionHeaderHeight = 10;
       self.tableView.sectionFooterHeight = 0;
       
      // self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
      
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
//        //设置leftBarButton
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
//        //设置rightBarButton
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
        
        
        
    }
    
    
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        
//        //设置leftBarButton
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
//        //设置rightBarButton
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
        
        
    }
    
    
    return self;
    
}

//设置默认view的图片 文字
- (void)setUpImgAndTitle{
    
    if (self.defaultView != nil) {
        self.defaultView.descriptionIconName = @"visitordiscover_image_profile";
        self.defaultView.info = @"登陆后,你的微博、相册、个人资料会显示在这里， 展示给别人";
    }
    
    
}


- (void)ClikLeftBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
}


- (void)ClickRightBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
    
}


- (void)setting
{
    // 跳转到设置界面
   CESettingTableViewController *settingVc = [[CESettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)setupitems
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建第一组数据
    CEArrowCommonItem *hotStatus = [CEArrowCommonItem itemWithIcon:@"hot_status" title:@"热门微博"];
    hotStatus.subTitle = @"(12)";
    CEArrowCommonItem *findPeople =  [CEArrowCommonItem itemWithIcon:@"find_people" title:@"找人"];
    findPeople.badgeValue = @"99";
    CEGroupCommon *group0 = [self addGroup];
    group0.items = @[hotStatus, findPeople];
    group0.header = @"上传图片质量";
    


}

- (void)setupGroup1
{
    // 2.创建第二组数据
    CEArrowCommonItem *gameCenter = [CEArrowCommonItem itemWithIcon:@"game_center" title:@"游戏中心"];
    gameCenter.badgeValue = @"12";
    CEArrowCommonItem *near = [CEArrowCommonItem itemWithIcon:@"near" title:@"周边"];
    CEArrowCommonItem *app = [CEArrowCommonItem itemWithIcon:@"app" title:@"应用"];
    CEGroupCommon *group1 = [self addGroup];
    group1.items =@[gameCenter, near, app];
    group1.header = @"下载图片质量";
}



@end
