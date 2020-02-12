//
//  CESettingTableViewController.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CESettingTableViewController.h"
#import "CEArrowCommonItem.h"
#import "CEGroupCommon.h"
#import "CEPictureTableViewController.h"

@interface CESettingTableViewController ()

@end

@implementation CESettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [super viewDidLoad];
     
     self.navigationItem.title = @"设置";
     
     [self setupitems];
     
     // 设置组与组之间的间隙
     self.tableView.sectionHeaderHeight = 0;
     self.tableView.sectionFooterHeight = 10;
     
     //self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    
    
}



- (void)setupitems
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    // 添加底部视图
    UIButton *footerBtn = [[UIButton alloc] init];
    [footerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [footerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [footerBtn setBackgroundImage:[UIImage imageNamed:@"common_card_middle_background"] forState:UIControlStateNormal];
    footerBtn.mj_h = 30;
    // 注意: 如果是tableView的顶部视图, 或者底部视图, 有默认的宽度
    self.tableView.tableFooterView = footerBtn;
}

/*
 *  0组
 */
- (void)setupGroup0
{
    CEArrowCommonItem *account = [CEArrowCommonItem itemWithTitle:@"帐号管理"];
     CEGroupCommon *group0 = [self addGroup];
     group0.items = @[account];
}

- (void)setupGroup1
{
    CEArrowCommonItem *theme = [CEArrowCommonItem itemWithTitle:@"主题、背景"];
    theme.destClass = [CEPictureTableViewController class];
    CEGroupCommon *group = [self addGroup];
    group.items = @[theme];
}

- (void)setupGroup2
{
    CEArrowCommonItem *notice = [CEArrowCommonItem itemWithTitle:@"通知和提醒"];
    CEArrowCommonItem *general = [CEArrowCommonItem itemWithTitle:@"通用设置"];
    CEArrowCommonItem *safe = [CEArrowCommonItem itemWithTitle:@"清除缓存"];
    //    NSInteger cache = arc4random_uniform(100);
    
    // 因为图片是通过sdwebimage下载, 所以应该查看sdwebimage中是否提供了获取当前缓存大小的方法
    //NSUInteger cacheSize = [[SDWebImageManager sharedManager].imageCache getSize];
    
    
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] totalDiskSize];
    
    
    
    DDLogDebug(@"cacheSize = %tu", cacheSize);
    safe.subTitle = [NSString stringWithFormat:@"(%.1fM)", cacheSize/(1000.0 * 1000)];
    __weak typeof(self) weakSelf = self;
    
    __weak typeof (safe) weakSafe = safe;
    
    safe.option = ^{
        // 1.显示正在清空
        //[MBProgressHUD showMessage:@"正在清空缓存"];
        
        JGProgressHUD *hub = [[JGProgressHUD alloc]init];
        
        hub.textLabel.text = @"正在清空缓存";
        
        [hub showInView:self.view animated:YES];
        
        
        // 清空缓存
        [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeDisk completion:^{
            
            
            //关闭提示
            [hub dismissAfterDelay:0.5 animated:YES];
            
            // 循环引用
            weakSafe.subTitle = nil;
            
            
            [weakSelf.tableView reloadData];
            
        }];
        
        
    };
    CEGroupCommon *group = [self addGroup];
    group.items = @[notice, general, safe];
}

- (void)dealloc
{
    DDFunc;
}

- (void)setupGroup3
{
   
    
    CEArrowCommonItem *opinion = [CEArrowCommonItem itemWithTitle:@"意见反馈"];
    CEArrowCommonItem *about = [CEArrowCommonItem itemWithTitle:@"关于微博"];
    CEGroupCommon *group = [self addGroup];
    group.items = @[opinion, about];
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
