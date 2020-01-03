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



static UIWindow *window;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    //设置searchbar
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    //设置 搜索框
    
    
    
    
    self.navigationItem.searchController = self.searchController;
    
    
    [self.navigationItem setHidesSearchBarWhenScrolling:YES];
    
    
    self.searchController.searchBar.placeholder = @"点击搜索感兴趣的事物";
    
    
    self.searchController.delegate = self;
    
    
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
   
    
    
    
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    
    
    textfield.backgroundColor = [UIColor redColor];
    
 
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    
    
    
    
    
    DDLogDebug(@"canBecomeFirstResponder %d",[textfield canBecomeFirstResponder]);
    
    
    //[searchbar becomeFirstResponder];
    
    
    
    
    DDFunc;
    DDLogDebug(@"isFirstResponder %d",self.searchController.searchBar.isFirstResponder);
    
   
   
    
   
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    DDFunc;
    DDLogDebug(@"isFirstResponder %d",self.searchController.searchBar.isFirstResponder);

    
}


- (void)didPresentSearchController:(UISearchController *)searchController{
    
   
  DDLogDebug(@"isFirstResponder %d",self.searchController.searchBar.isFirstResponder);
    
    
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
        
//        //设置leftBarButton
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
//        //设置rightBarButton
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
//
        
        
        
        
    }
    
    
    return self;
    
}



#pragma mark -
#pragma mark -- UISearchControllerDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
    DDFunc;
    
    searchController.searchBar.showsCancelButton = YES;
    
    [searchController.searchBar.subviews[0].subviews[1].subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        
        DDFunc;
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            [obj setValue:@"取消" forKeyPath:@"title"];
        }
        
       
      
        
    }];
    
    
}




#pragma mark -
#pragma mark -- 懒加载searchBarController

- (UISearchController *)searchController{
    
    if (_searchController == nil) {
        
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
          
        
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
