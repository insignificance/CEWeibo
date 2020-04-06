//
//  CEHomeViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEHomeViewController.h"
#import "CEScannerController.h"
#import "CETitleView.h"
#import "CEHomeCell.h"
#import <XHPopMenu/XHPopMenu.h>
#import <AFNetworking/AFNetworking.h>
#import "CEStatues.h"
#import "CEUser.h"
#import "CEStatuesRequest.h"
#import "CEStatuesResult.h"

#import "CERefreshGifHeader.h"





@interface CEHomeViewController ()<CEHomeCellDelegate>

@property (nonatomic,weak)CETitleView *cetitleView;

/* statues 模型数组 */
@property (nonatomic,strong) NSMutableArray *statuesDateArr;




@end

@implementation CEHomeViewController


/* cell 重用标识符 */
static NSString *reuseID = @"CEHomeCell";

#pragma mark -
#pragma mark -- viewcontroller life recycle

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    
    if (self.defaultView != nil) {
        
        [self.defaultView startRotate];
        
    }
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //设置BarButtonItem
    
    
    [self setUpBarButtonItem];
    
    
    //创建自定义titleview
    
    [self setUpTitleView:@"首页" andImage:@"navigationbar_arrow_down"];
    
    
    
    
    
    if (self.defaultView !=nil) {
        
        //初始化中间视图
        [self setUpImgAndTitle];
        
    }else{
        
        //设置用户数据
        [self setUpUserInfo];
        
        //设置微博数据
        
        //[self loadNewStatuese];
        
        //设置微博数据 兼顾下拉刷新控件
        
        [self setUpRefresh];
        
        
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}




- (void)viewWillDisappear:(BOOL)animated{
    
    
    [super viewWillDisappear:animated];
    
    if (self.defaultView != nil) {
        
        [self.defaultView stopRotate];
        
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
#pragma mark -- 初始化方法


- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    
    if (self = [super initWithStyle:style]) {
        
        
        
        //设置BarButtonItem
        
        
        [self setUpBarButtonItem];
        
        
        //创建自定义titleview
        
        [self setUpTitleView:@"首页" andImage:@"navigationbar_arrow_down"];
        
        
        
        //设置默认view 的 图片 文字 应该延后
        
        //[self setUpImgAndTitle];
        
        
    }
    
    
    return self;
    
}


#pragma mark -
#pragma mark -- 懒加载数据

- (NSMutableArray *)statuesDateArr{
    
    if (nil == _statuesDateArr) {
        
        
        _statuesDateArr = [NSMutableArray array];
        
    
    }
    
    
    return _statuesDateArr;
    
}




#pragma mark -
#pragma mark -- 设置用户数据


- (void)setUpUserInfo{
    
    
    //1. 获取管理对象
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    CENetWorkingTools *tools = [CENetWorkingTools shareNetworkTools];
    
    //2. 加载用户数据
    [tools loadUserInfo:^(CEUser *responseObject){
        
        DDLogDebug(@"获取用户信息成功 = %@",responseObject);
        
        CEAccount *accout = [CEAccountTool accountFromSandbox];
        
        //取出高清用户头像urlString
        
        //NSString *avatar_large = [responseObject valueForKeyPath:@"avatar_large"];
        
        NSString *avatar_large = responseObject.avatar_large;
        
        //判断和本地的已存储的用户头像url 是否一致 一致就返回
        if ([accout.avatar_large isEqualToString:avatar_large]) {
            
            return ;
            
        }else{ //不一致就更新本地高清头像url
            
            accout.avatar_large = avatar_large;
            
            [CEAccountTool savaAccount:accout];
            
        }
        
        
    } failure:^(NSError * _Nonnull error){
        
        DDLogDebug(@"获取用户信息失败");
        
        DDLogDebug(@"error = %@",error);
        
        
        
    }];
    
    
    /*
     //2. 封装请求参数
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     
     
     //2.1 获取用户模型对象
     
     CEAccount *accout = [CEAccountTool accountFromSandbox];
     
     parameters[@"access_token"] = accout.access_token;
     parameters[@"uid"] = accout.uid;
     
     */
    
    
    /*
     
     //3. api urlString
     NSString *urlString  = @"https://api.weibo.com/2/users/show.json";
     //4. 发送请求
     [manager GET:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     //取出头像urlString
     NSString *profile_imgae_url = [responseObject valueForKeyPath:@"profile_image_url"];
     
     //判断和本地的已存储的用户头像url 是否一致 一致就返回
     if ([accout.profile_image_url isEqualToString:profile_imgae_url]) {
     return ;
     }else{ //不一致就更新本地头像url
     
     accout.profile_image_url =  profile_imgae_url;
     
     [CEAccountTool savaAccount:accout];
     
     }
     
     
     //取出高清用户头像urlString
     
     NSString *avatar_large = [responseObject valueForKeyPath:@"avatar_large"];
     
     //判断和本地的已存储的用户头像url 是否一致 一致就返回
     if ([accout.avatar_large isEqualToString:avatar_large]) {
     return ;
     }else{ //不一致就更新本地高清头像url
     
     accout.avatar_large = avatar_large;
     
     [CEAccountTool savaAccount:accout];
     
     }
     
     
     //DDLogDebug(@"%@",responseObject);
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     
     DDLogDebug(@"%@",error);
     
     
     }];
     
     */
    
    
    
}

#pragma mark -
#pragma mark -- 获取微博数据 / 兼顾下拉刷新

-(void)loadNewStatuese{
    
    
    // 0.清空提醒数字
    self.tabBarItem.badgeValue= @"";
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    /*
     //1.获取管理对象
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     
     //2.封装参数
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     
     //2.1获取模型对象
     
     CEAccount *account = [CEAccountTool accountFromSandbox];
     
     //2.2 获取令牌
     
     parameters[@"access_token"] = account.access_token;
     
     //2.3 设置默认返回的数据量（可选默认20条)
     
     parameters[@"count"] = @20;
     
     
     //2.4 取出数组中第一个元素的id
     
     NSString *firstStatusIdStr = [[self.statuesDateArr firstObject] idstr];
     
     //有数据则 添加下拉刷新需要的参数
     if (firstStatusIdStr != nil) {
     
     parameters[@"since_id"] = firstStatusIdStr;
     
     }
     
     */
    
    //1. 获取管理对象
    
    CENetWorkingTools *tools = [CENetWorkingTools shareNetworkTools];
    
    //2. 封装请求参数
    //2.1 获取用户信息
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    CEStatuesRequest *parameters = [CEStatuesRequest new];
    
    parameters.access_token = account.access_token;
    
    parameters.count = @20;
    
    
    //2.2 取出数组中第一个元素的id
    NSString *firstStatusIdStr = [[self.statuesDateArr firstObject] idstr];
    
    //有数据则 添加下拉刷新需要的参数
    if (firstStatusIdStr != nil) {
        
        parameters.since_id = [NSNumber numberWithLongLong:[firstStatusIdStr longLongValue]];
        
    }
    
    
    DDLogDebug(@"access_token%@",account.access_token);
    
    
    [tools loadHomeStatusWithParameters:parameters success:^(CEStatuesResult * _Nonnull result) {
        
        //DDLogDebug(@"%@",responseObject);
        
        
        
        //[self.statuesDateArr addObjectsFromArray:statuesArray];
        
        //第一次启动 数组里没数据 所以从第一个开始插入和末尾拆入都是一个意思
        
        NSRange range = NSMakeRange(0, result.statues.count);
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statuesDateArr insertObjects:result.statues atIndexes:indexSet];
        
        //刷新tableview 数据
        
        [self.tableView reloadData];
        
        
        //关闭刷新
        
        [self.tableView.mj_header endRefreshing];
        
        // 显示提醒
        [self showNewStatusWithCount:result.statues.count];
        
        
        
        // DDLogDebug(@"%@",responseObject);
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        //关闭刷新
        
        [self.tableView.mj_header endRefreshing];
        
        
        
        DDLogDebug(@"%@",error);
        
        
        
    }];
    
    
    /*
     NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
     
     
     
     [manager GET:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     
     
     //DDLogDebug(@"%@",responseObject);
     
     
     //获取statues 字典数组
     NSArray *dictArray = responseObject[@"statuses"];
     
     //转换成模型 数组
     NSMutableArray *statuesArray = [CEStatues mj_objectArrayWithKeyValuesArray:dictArray];
     
     //[self.statuesDateArr addObjectsFromArray:statuesArray];
     
     //第一次启动 数组里没数据 所以从第一个开始插入和末尾拆入都是一个意思
     
     NSRange range = NSMakeRange(0, statuesArray.count);
     
     NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
     
     [self.statuesDateArr insertObjects:statuesArray atIndexes:indexSet];
     
     //刷新tableview 数据
     
     [self.tableView reloadData];
     
     
     //关闭刷新
     
     [self.tableView.mj_header endRefreshing];
     
     // 显示提醒
     [self showNewStatusWithCount:statuesArray.count];
     
     
     
     // DDLogDebug(@"%@",responseObject);
     
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     //关闭刷新
     
     [self.tableView.mj_header endRefreshing];
     
     
     
     DDLogDebug(@"%@",error);
     
     }];
     
     */
    
    
    
}



#pragma mark -
#pragma mark -- 上拉加载更多


- (void)loadMoreStatues{
    
    
    // 0.清空提醒数字
    self.tabBarItem.badgeValue = @"";
    
    DDLogDebug(@"homeViewControlle = %@",self);
    
    /*
     //1.获取管理对象
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     
     //2.封装参数
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     
     //2.1获取模型对象
     
     CEAccount *account = [CEAccountTool accountFromSandbox];
     
     //2.2 获取令牌
     
     parameters[@"access_token"] = account.access_token;
     
     //2.3 设置默认返回的数据量（可选默认20条)
     
     parameters[@"count"] = @20;
     
     
     //2.4 取出数组中第一个元素的id
     
     NSString *lastStatusIdStr = [[self.statuesDateArr lastObject] idstr];
     
     //有数据则 添加下拉刷新需要的参数
     if (lastStatusIdStr != nil) {
     
     parameters[@"max_id"] = @([lastStatusIdStr longLongValue] - 1);
     
     }
     
     */
    
    //1. 获取管理对象
    
    CENetWorkingTools *tools = [CENetWorkingTools shareNetworkTools];
    
    //2.封装请求参数
    
    CEStatuesRequest *parameters = [CEStatuesRequest new];
    
    //2.1 获取模型对象
    
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    //获取令牌
    
    parameters.access_token = account.access_token;
    
    //设置默认返回的数据量 (可默认选20条)
    
    parameters.count = @20;
    
    //取出数组中第一个元素的id
    
    NSString *lastStatusIdStr = [[self.statuesDateArr lastObject] idstr];
    
    //有数据则 调价上拉刷新需要的参数
    
    if (lastStatusIdStr !=nil) {
        
        parameters.max_id = @([lastStatusIdStr longLongValue] - 1);
        
    }
    
    
    DDLogDebug(@"access_token%@",account.access_token);
    
    
    [tools loadHomeStatusWithParameters:parameters success:^(CEStatuesResult * _Nonnull result) {
        
        
        DDLogDebug(@"%@",result);
        
        
        //获取模型 数组
        NSArray *statuesArray = result.statues;
        
        [self.statuesDateArr addObjectsFromArray:statuesArray];
        
        //刷新tableview 数据
        
        [self.tableView reloadData];
        
        
        //关闭刷新
        
        [self.tableView.mj_footer endRefreshing];
        
        
        // DDLogDebug(@"%@",responseObject);
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        //关闭刷新
        
        [self.tableView.mj_footer endRefreshing];
        
        
        
        DDLogDebug(@"%@",error);
        
        
        
    }];
    
    
    
    /*
     NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
     
     
     
     [manager GET:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     
     
     DDLogDebug(@"%@",responseObject);
     
     
     //获取statues 字典数组
     NSArray *dictArray = responseObject[@"statuses"];
     
     //转换成模型 数组
     NSMutableArray *statuesArray = [CEStatues mj_objectArrayWithKeyValuesArray:dictArray];
     
     [self.statuesDateArr addObjectsFromArray:statuesArray];
     
     
     //刷新tableview 数据
     
     [self.tableView reloadData];
     
     
     //关闭刷新
     
     [self.tableView.mj_footer endRefreshing];
     
     
     // DDLogDebug(@"%@",responseObject);
     
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     //关闭刷新
     
     [self.tableView.mj_footer endRefreshing];
     
     
     
     DDLogDebug(@"%@",error);
     
     }];
     
     */
    
    
    
    
    
    
    
}


#pragma mark -
#pragma mark -- 设置刷新控件

- (void)setUpRefresh{
    
    
    
    //UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    
    //[self.tableView addSubview:refreshControl];
    
    
    //[refreshControl addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    
    
    //MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshStatus)];
    
    
    //@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;
    
    //CGFloat LargTitleHeight = 60.5;
    
    //header.ignoredScrollViewContentInsetTop = LargTitleHeight;
    
    
    // 1. 添加下拉刷新
    
    //MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatuese)];
    
    CERefreshGifHeader *header = [CERefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatuese)];
    
    self.tableView.mj_header  = header;
    
    //启动的时候立即调用一次刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    
    //1. 添加上拉刷新
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatues)];
    
    
    
    
    
    
}


//- (void)viewDidLayoutSubviews{
//
//    [super viewDidLayoutSubviews];
//
//   NSLog(@"-----%f",self.view.safeAreaInsets.top);
//}


#pragma mark -
#pragma mark -- 刷新提醒

- (void)showNewStatusWithCount: (NSInteger)count{
    
    //1. 创建UILabel
    
    UILabel *label = [UILabel new];
    
    //2. 设置相关属性
    
    label.backgroundColor = [UIColor orangeColor];
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.alpha = 0.0;
    
    if (count > 0) {
        
        label.text = [NSString stringWithFormat:@"更新到%tu条微博数据",count];
        
    }else{
        
        
        label.text = @"未发现新的微博数据";
        
    }
    
    label.mj_x = 0;
    label.mj_h = 30;
    
    //    //判断是否刘海屏
    //    if (@available(iOS 11.0, *)) {
    //
    //        //CGFloat a = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    //
    //        CGFloat a = self.view.safeAreaInsets.top;
    //
    //        //NSLog(@"%@",NSStringFromUIEdgeInsets([UIApplication sharedApplication].delegate.window.safeAreaInsets));
    //
    //        if (a > 64) {
    //            //是
    //        label.mj_y = 88 - label.mj_h;
    //
    //        }else{
    //
    //            //不是
    //            label.mj_y = 64 - label.mj_h;
    //
    //        }
    //
    //
    //    }
    
    //根据safeAreaInsets 适配各类屏幕
    label.mj_y = self.view.safeAreaInsets.top - label.mj_h;
    
    label.mj_w = self.view.mj_w;
    
    //3. 添加到父控件
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    
    // 4.执行动画显示UILable
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 1.0;
        // 让label慢慢出现
        label.transform = CGAffineTransformMakeTranslation(0, label.mj_h);
        
    } completion:^(BOOL finished) {
        // 让label慢慢会去
        [UIView animateWithDuration:1 delay:1 options:0 animations:^{
            label.alpha = 0.0;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    
    //清除小红点
    
    self.navigationController.tabBarItem.badgeValue = @"0";
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
    
    
}



#pragma mark -
#pragma mark -- 设置默认view的图片 文字

- (void)setUpImgAndTitle{
    
    self.defaultView.backgroundimgName = @"visitordiscover_feed_image_smallicon";
    
    self.defaultView.info = @"当你关注一些人以后，他们发布的最新消息会显示在这里";
    
    self.defaultView.descriptionIconName = @"visitordiscover_feed_image_house";
    
    
    
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
#pragma mark -- 创建自定义titleview

- (void)setUpTitleView:(NSString *)title andImage:(NSString *)image{
    
    UIButton *titleBtn = [[UIButton alloc]init];
    
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    
    UIImageView *accImgView = [[UIImageView alloc]init];
    accImgView.image = [UIImage imageNamed:image];
    
    [accImgView sizeToFit];
    
    CETitleView *titleView = [[CETitleView alloc]initWithBtn:titleBtn andImageView:accImgView];
    
    self.cetitleView = titleView;
    
    //设置内置按钮 文字颜色
    
    [titleView.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    //为内置按钮添加点击事件
    
    [titleView.button addTarget:self action:@selector(ClickTitleView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleView;
    
    //self.navigationItem.titleView.backgroundColor = [UIColor greenColor];
    
    
}







#pragma mark -
#pragma mark -- 点击titlView

- (void)ClickTitleView:(UIButton *)btn{
    
    
    
    //改变titleView 指示器图片
    [self changeIndicator];
    
    
    
    //创建 xhpopMenu
    NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"我", @"我的好友", @"科技", @"美食", @"热点", @"随便看看"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:nil block:^(XHPopMenuItem *item) {
            [self changeIndicator];
            NSLog(@"block:%@",item);
        }];
        
        
        [tempArr addObject:model];
    }
    
    XHPopMenuConfiguration *option = [XHPopMenuConfiguration defaultConfiguration];
    option.style = XHPopMenuAnimationStyleScale;
    option.maskBackgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    [option setDismissBlock:^{
        
        [self changeIndicator];
        
        
    }];
    
    //[XHPopMenu showMenuInView:nil withRect:CGRectMake(10, 20, 120, 40) menuItems:tempArr withOptions:option];
    
    [XHPopMenu showMenuWithView:self.cetitleView menuItems:tempArr withOptions:option];
    
    
    
    
    
    
    DDFunc;
    
}


#pragma mark -
#pragma mark -- 改变titleview 的图片

- (void)changeIndicator{
    
    
    self.cetitleView.click = !self.cetitleView.click;
    
    if (self.cetitleView.isClik) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cetitleView.imageView.image = [UIImage imageNamed:@"navigationbar_arrow_up"];
            
        }];
        
    }else{
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cetitleView.imageView.image = [UIImage imageNamed:@"navigationbar_arrow_down"];
            
        }];
        
        
        
    }
    
    
}


#pragma mark -
#pragma mark -- 点击左侧barbutton


- (void)ClikLeftBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
}



#pragma mark -
#pragma mark -- 点击右侧barbutton

- (void)ClickRightBarButton:(UIButton *)btn{
    
    
    //DDFunc;
    //获取CEStoryboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CEStoryboard" bundle:nil];
    
    CEScannerController *scannerVc = [sb instantiateInitialViewController];
    
    [self presentViewController:scannerVc animated:YES completion:nil];
    
    
    
}


#pragma mark -
#pragma mark -- UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.statuesDateArr.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CEHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //下面这个必须注册cell
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    //    if (cell == nil) {
    //
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    //
    //
    //    }
    
    
    //取出用户模型对象
    CEStatues *statues = self.statuesDateArr[indexPath.row];
    
    
    cell.statues = statues;
    
    //CEUser *user = statues.user;
    
    //cell.textLabel.text = user.name;
    
    //cell.detailTextLabel.text = statues.text;
    
    //cell.detailTextLabel.text = statues.source;
    
    //cell.detailTextLabel.text = statues.created_at;
    
    
    
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    
    
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //DDFunc;
    
    
    
    
    
}


//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CEStatues *statues = self.statuesDateArr[indexPath.row];
    if (statues.cellHeight <= 0) {
        
        CEHomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        statues.cellHeight = [homeCell cellHeightWithStatus:statues];
    }
    
    return statues.cellHeight;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    
    
    DDFunc;
    
    
}

@end
