//
//  CEPictureTableViewController.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEPictureTableViewController.h"
#import "CECheckGroupCommon.h"
#import "CECheckCommonItem.h"
#import "CEGroupCommon.h"


@interface CEPictureTableViewController ()
@property(nonatomic,strong) CECheckCommonItem *high;
@property(nonatomic,strong) CECheckCommonItem *normal;
@end

@implementation CEPictureTableViewController




- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    self.navigationItem.title = @"图片质量设置";
    
    [self setupItems];
    
    
    
}


// 通用数据
- (void)setupItems
{
    /** 0组 */
    [self setupGroup0];
    
    /** 1组 */
    [self setupGroup1];
}


- (void)setupGroup0
{
    
    CECheckCommonItem *high = [CECheckCommonItem itemWithTitle:@"高清"];
    high.subTitle = @"(建议在wifi或3G网络使用)";
    high.check = NO;
    self.high = high;

    CECheckCommonItem *normal = [CECheckCommonItem itemWithTitle:@"普通"];
    normal.subTitle = @"(上传速度快，省流量)";
    normal.check = YES;
    self.normal = normal;
    
    
    CECheckCommonItem *normal2 = [CECheckCommonItem itemWithTitle:@"普通2"];
    normal2.subTitle = @"(上传速度快，省流量2)";
    normal2.check = NO;

    
//    IWGroupCommon  *group0 = [self addGroup];
    CECheckGroupCommon *group0 = (CECheckGroupCommon *)[self addCheckGroup];
    group0.header = @"上传图片质量";
    group0.items = @[high, normal, normal2];
}
- (void)setupGroup1
{
    CECheckCommonItem *normal = [CECheckCommonItem itemWithTitle:@"普通"];
    normal.subTitle = @"(上传速度快，省流量)";
    normal.check = YES;
    
    CECheckCommonItem *normal2 = [CECheckCommonItem itemWithTitle:@"普通"];
    normal2.subTitle = @"(上传速度快，省流量)";
    normal2.check = NO;
    
    CECheckGroupCommon  *group1 = (CECheckGroupCommon *)[self addCheckGroup];
    group1.items = @[normal, normal2];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning 这样虽然能做, 但是这种做法不好\
判断比较复杂, 如果当前组的cell行数比较多的情况, 那么要写很多if else if \
扩展性不好, 如果开始的时候当前组有2行, 以后需求变更, 无论是变多还是变少我们都需要重新修改代码
    
    /*
     当前组有多少行谁最清楚? 组模型
     所以当前组选中哪一行, 也应该是组模型最清楚
     最终做法: 搞一个组模型保存当前组中每一行的模型数据, 然后定义属性记录当前选中的行, 遍历组模型中所有的行的模型, 判断如果遍历出来的行的模型的索引和当前选中的索引相同就设置为选中, 否则就设置为取消选中
     */
    /*
     当前微博遗留的问题:
     1.首页通过数据库缓存数据
     2.发现和我界面父类抽取(先尝试)
     3.发现和我界面子标题距离问题(先尝试)
     4.单选图标(先尝试)
     */
    /*
    // 切换选中状态
    if (self.high.check == YES) {
        self.high.check = NO;
        self.normal.check = YES;
    }else
    {
        self.high.check = YES;
        self.normal.check = NO;
    }
     */
    
    // 1.取出当前选中的组
    CECheckGroupCommon *group = [self groupWithSection:indexPath.section];
    // 2.告诉当前选中的组选中哪一行
    group.currentIndex = indexPath.row;
    // 3.刷新界面
    [self.tableView reloadData];
    
}




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
