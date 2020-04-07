//
//  CEDefaultCenterVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEDefaultCenterVC.h"
#import "CEDefaultCenterView.h"
#import "CEOAuthViewController.h"
#import "CEAccountTool.h"
#import "CEAccount.h"
#import "CEGroupCommon.h"
#import "CECheckGroupCommon.h"
#import <WebKit/WebKit.h>
#import "CECommonItem.h"
#import "CEItemTableViewCell.h"
@interface CEDefaultCenterVC ()<CEDeflaultCenterViewDelegate,WKNavigationDelegate>
@property (nonatomic,strong)JGProgressHUD *hub;

/**
 *  存储所有组的组模型(IWGroupCommon)
 */
@property(nonatomic,strong)NSMutableArray *groups;



@end

@implementation CEDefaultCenterVC



- (void)loadView{
    
    
    //1. 取出沙河中存储的授权信息
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    
    //2. 判断时候有授权信息
    
    if (account == nil) {
        
        CEDefaultCenterView *defaultView = [CEDefaultCenterView defaultCenterView];
        self.view = defaultView;
        self.defaultView = defaultView;
        
        //设置代理属性
        self.defaultView.delegate = self;
    }else{
        
        
        
        [super loadView];
        
        
    }
    

    
}


#pragma mark -
#pragma mark -- 懒加载hub

-(JGProgressHUD *)hub{
    
    if (_hub == nil) {
        
        _hub = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        
    }
    
    return _hub;
    
    
}



#pragma mark -
#pragma mark -- CEDefaultViewDelegate

- (void)defaultCenterView:(CEDefaultCenterView *)defaultView didClickLogInBtn:(UIButton *)logInBtn{
    
    
    //打开登陆界面
    
    CEOAuthViewController *oauthVc = [[CEOAuthViewController alloc]init];
    
    
    //oauthVc.view.backgroundColor = [UIColor greenColor];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:oauthVc];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
    
    DDFunc;
    
}





/// 注册账号
- (void)defaultCenterView:(CEDefaultCenterView *)defaultView didClickSignUpBtn:(UIButton *)signUpBtn{
    
   

    //打开注册界面
    UIViewController *sigInVC = [[UIViewController alloc]init];
  
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    sigInVC.view = webView;
    
    
    //显示加载提示
    self.hub.textLabel.text  = @"正在加载";
                
    [self.hub showInView:webView animated:YES];
    
    
    webView.navigationDelegate = self;
    
    
    UINavigationController *sigInNav = [[UINavigationController alloc]initWithRootViewController:sigInVC];
    
    sigInVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    [self presentViewController:sigInNav animated:YES completion:^{
        
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.weibo.cn/login?backURL=https%253A%252F%252Fm.weibo.cn%252F"]]];
  
    }];
    
    
    
    
    
    
    
    DDFunc;
    
    
}

#pragma mark -
#pragma mark -- 取消注册
- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

//加载结束

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //[ProgressHUD dismiss];
    DDFunc;
    
    [self.hub dismissAnimated:YES];
    
    
}



//加载失败

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    
    DDFunc;
    
    self.hub.textLabel.text = @"加载失败";
    
    [self.hub dismissAfterDelay:1.5 animated:YES];
    
    
}








- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    
    if (self = [super initWithStyle:style]) {
        
        
        //self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        
        
        
    }
    
    return self;
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}






#pragma mark - 数据源代理方法
// 一共有多少组, 如果不实现默认有1组, 如果返回0代表一组都没有
// 由于首页中没有实现numberOfSectionsInTableView方法, 但是系统默认会调用该方法询问一共有多少组, 那么子类没有就会调用父类的该方法, 由于首页调用父类的该方法返回0, 所以导致首页数据不显示
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DDLogDebug(@"%tu", self.groups.count);
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CEGroupCommon *group = self.groups[section];
    return group.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.创建cell
    CEItemTableViewCell *cell = [CEItemTableViewCell cellWithTableView:tableView];
    // 2.设置数据模型
    // 1.取出对应组的数组
    CEGroupCommon *group = self.groups[indexPath.section];
    // 2.取出对应行的模型
    CECommonItem *item = group.items[indexPath.row];
    cell.item = item;
    // 传递当前对应的行和当前组总共的行数
    [cell setcurrentIndex:indexPath.row totalCount:group.items.count];
    // 3.返回cell
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 1.取出对应组的模型
    if (self.groups.count > 0) {
        
        CEGroupCommon *group = self.groups[section];
        // 2.返回标题
        return group.header;
    }
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 1.取出对应组的模型
    if (self.groups.count > 0) {
        CEGroupCommon *group = self.groups[section];
        // 2.返回标题
        return group.footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出点击的组
    CEGroupCommon *group = self.groups[indexPath.section];
    // 2.取出点击的行
    CECommonItem *item = group.items[indexPath.row];
    // 3.判断行对应的模型的destClass属性是否为nil
    // 如果不为nil, 那么创建对应的目标控制器跳转即可
    if (item.destClass != nil) {
        UIViewController *vc = [[item.destClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // 判断是否有需要执行的代码块
    if (item.option != nil) {
        item.option();
    }
}

#pragma makr - 懒加载
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)addGroup:(CEGroupCommon *)group
{
    [self.groups addObject:group];
}


- (CEGroupCommon *)addGroup
{
    CEGroupCommon *group = [[CEGroupCommon alloc] init];
    [self.groups addObject:group];
    return group;
}

- (CEGroupCommon *)addCheckGroup
{
    CECheckGroupCommon *group = [[CECheckGroupCommon alloc] init];
    [self.groups addObject:group];
    return group;
}

- (CEGroupCommon *)groupWithSection:(NSInteger)section
{
    return self.groups[section];
}
















//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
