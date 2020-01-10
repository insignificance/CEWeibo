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

@interface CEDefaultCenterVC ()<CEDeflaultCenterViewDelegate>

@end

@implementation CEDefaultCenterVC



- (void)loadView{
    
    
    //1. 取出沙河中存储的授权信息
    CEAccount *account = [CEAccountTool account];
    
    
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
#pragma mark -- CEDefaultViewDelegate

- (void)defaultCenterView:(CEDefaultCenterView *)defaultView didClickLogInBtn:(UIButton *)logInBtn{
    
    
    //打开登陆界面
    
    CEOAuthViewController *oauthVc = [[CEOAuthViewController alloc]init];
    
    oauthVc.view.backgroundColor = [UIColor greenColor];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:oauthVc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
    
    DDFunc;
    
}


- (void)defaultCenterView:(CEDefaultCenterView *)defaultView didClickSignInBtn:(UIButton *)signInBtn{
    
    //打开注册界面
    DDFunc;
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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