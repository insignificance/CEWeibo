//
//  CEDiscoverViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEDiscoverViewController.h"

@interface CEDiscoverViewController ()

@end

@implementation CEDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    //设置searchbar
//    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
//    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    //设置 搜索框
    
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    self.navigationItem.searchController = searchController;
    
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
    
    
    
    
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
        
        //设置leftBarButton
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
        //设置rightBarButton
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
        
        
        
    }
    
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        
        //设置leftBarButton
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
        //设置rightBarButton
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
        
        
        
        
        
    }
    
    
    return self;
    
}




- (void)ClikLeftBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
}


- (void)ClickRightBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
    
}


@end
