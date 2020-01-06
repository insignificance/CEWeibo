//
//  CEDiscoverViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEDiscoverViewController.h"

@interface CEDiscoverViewController ()<UISearchControllerDelegate>

@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation CEDiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置searchbar
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    
    //设置searchController
    [self setUpSearchController];
    
    
    //设置默认view 的 图片 文字
    [self setUpImgAndTitle];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    
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
    
    
    [self.navigationItem setHidesSearchBarWhenScrolling:YES];
    
    
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
