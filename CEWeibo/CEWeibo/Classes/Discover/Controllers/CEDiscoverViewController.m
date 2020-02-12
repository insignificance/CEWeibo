//
//  CEDiscoverViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEDiscoverViewController.h"
#import "CECheckGroupCommon.h"
#import "CEGroupCommon.h"
#import "CEArrowCommonItem.h"
#import "CESwitchCommonItem.h"
#import "CELabelCommonItem.h"
#import "CEMoreTableViewController.h"

@interface CEDiscoverViewController ()<UISearchControllerDelegate>

@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation CEDiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    //设置BarButtonItem
          
          
    [self setUpBarButtonItem];
    
    
    //设置searchbar
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    
    //设置searchController
    [self setUpSearchController];
    
    
    //设置默认view 的 图片 文字
    [self setUpImgAndTitle];
    
    
    
    // 初始化数据
       [self setupitems];
       
       // 设置组与组之间的间隙
       self.tableView.sectionHeaderHeight = 10;
       self.tableView.sectionFooterHeight = 0;
       
       DDLogDebug(@"contentInset = %@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
       
       //self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
       
       // 取出系统自带的分割线
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    
}



- (void)setupitems
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建第一组数据
    CEArrowCommonItem *hotStatus = [CEArrowCommonItem itemWithIcon:@"hot_status" title:@"热门微博"];
    hotStatus.subTitle = @"笑话，娱乐，神最右都搬到这啦";
    CEArrowCommonItem *findPeople =  [CEArrowCommonItem itemWithIcon:@"find_people" title:@"找人"];
    hotStatus.subTitle = @"名人、有意思的人尽在这里";
    CEGroupCommon *group0 = [self addGroup];
    group0.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 2.创建第二组数据
    CESwitchCommonItem *gameCenter = [CESwitchCommonItem itemWithIcon:@"game_center" title:@"游戏中心"];
    CESwitchCommonItem *near = [CESwitchCommonItem itemWithIcon:@"near" title:@"周边"];
    CESwitchCommonItem *app = [CESwitchCommonItem itemWithIcon:@"app" title:@"应用"];
    CEGroupCommon *group1 = [self addGroup];
    group1.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    CELabelCommonItem *video = [CELabelCommonItem itemWithIcon:@"video" title:@"视频"];
    video.text = @"label显示的文本";
    
    CECommonItem *music = [CECommonItem itemWithIcon:@"music" title:@"音乐"];
    music.option = ^{
        //[MBProgressHUD showSuccess:@"播放音乐成功"];
        
        JGProgressHUD *hub = [[JGProgressHUD alloc]init];
        hub.textLabel.text = @"播放音乐成功";
        
        [hub showInView:self.view animated:YES];
        
        [hub dismissAfterDelay:1.0 animated:YES];
        
        
    };
    
    CECommonItem *movie = [CECommonItem itemWithIcon:@"movie" title:@"电影"];
    CECommonItem *cast = [CECommonItem itemWithIcon:@"cast" title:@"播客"];
    CECommonItem *more = [CECommonItem itemWithIcon:@"more" title:@"更多"];
    // 通过属性保存更多选项需要跳转到的目标控制器
    more.destClass = [CEMoreTableViewController class];
    
    CEGroupCommon *group2 = [[CEGroupCommon alloc] init];
    group2.items = @[video, music, movie, cast, more];
    
    // 3.将两组数据添加到数组中
    [self addGroup:group2];
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//
//
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//
//        //设置leftBarButton
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
//        //设置rightBarButton
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
//
//
//
//    }
//
//
//    return self;
//}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        
        
        
        //设置BarButtonItem
        
        
        [self setUpBarButtonItem];
        
        
        //设置默认view 的 图片 文字 应该延后
        
        //[self setUpImgAndTitle];
        
        
        
    }
    
    
    return self;
    
}


#pragma mark -
#pragma mark -- 设置BarButtonItem

- (void)setUpBarButtonItem{
    
    
    
    //设置leftBarButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
    //设置rightBarButton
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
    
    
    
}

#pragma mark -
#pragma mark -- 设置默认view 的 图片 文字

- (void)setUpImgAndTitle{
    
    
    
    self.defaultView.info = @"当你关注一些人以后，他们发布的最新消息会显示在这里";
    
    self.defaultView.descriptionIconName = @"visitordiscover_feed_image_house";
    
    
    
}

#pragma mark -
#pragma mark -- 设置searchController

- (void)setUpSearchController{
    
    
    
    
    //设置 搜索框
    
    self.navigationItem.searchController = self.searchController;
    
    
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
    
    
    self.searchController.searchBar.placeholder = @"点击搜索感兴趣的事物";
    
    
    self.searchController.delegate = self;
    
    
    //kvc 修改私有属性
    [self.searchController.searchBar setValue:@"取消" forKey:@"cancelButtonText"];
    
}




#pragma mark -
#pragma mark -- UISearchControllerDelegate


- (void)willPresentSearchController:(UISearchController *)searchController{
    
    
    
    
}

- (void)didPresentSearchController:(UISearchController *)searchController{
    
    
    
}

- (void)presentSearchController:(UISearchController *)searchController{
    
    
    
    
    
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
    
    
    
}




#pragma mark -
#pragma mark -- 懒加载searchBarController

- (UISearchController *)searchController{
    
    if (_searchController == nil) {
        
        _searchController = [[UISearchController alloc]initWithSearchResultsController:[UIViewController new]];
        
        _searchController.delegate = self;
        
    }
    
    return _searchController;
    
}




- (void)ClikLeftBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
}


- (void)ClickRightBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
    
}


@end
