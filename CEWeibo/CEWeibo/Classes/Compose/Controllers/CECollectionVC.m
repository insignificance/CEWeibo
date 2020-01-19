//
//  CECollectionVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/18.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CECollectionVC.h"
#import "CEPhotoCell.h"

@interface CECollectionVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) NSMutableArray *images;


@end

@implementation CECollectionVC

static NSString * const reuseIdentifier = @"Cell";



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //1. 注册通知监听 item 的添加和删除通知
       
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addPhoto:) name:CEAddPhotoNotification object:nil];
       
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deletePhoto:) name:CEDeletePhotoNotification object:nil];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    
   
    
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    //移除通知
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CEAddPhotoNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CEDeletePhotoNotification object:nil];
    
    
    
}



#pragma mark -
#pragma mark -- 懒加载

- (NSMutableArray *)images{
    
    
    if (nil == _images) {
        
        
        _images = [NSMutableArray array];
        
    }
    
    return _images;
    
}




#pragma mark -
#pragma mark -- 添加图片
- (void)addPhoto:(NSNotification *)noti{
    
    
    DDFunc;
    
    //1. 创建图片选择控制器
    
    UIImagePickerController *picker = [UIImagePickerController new];
 
    self.picker = picker;
    //2. 弹出图片选择控制器
 
    [self presentViewController:picker animated:YES completion:nil];
    
    //设置代理 监听选中图片
    self.picker.delegate = self;
    
    
    
    
    
}


#pragma mark -
#pragma mark -- 删除图片
- (void)deletePhoto:(NSNotification *)noti{
    
    CEPhotoCell *cell = noti.object;
    
    [self.images removeObjectAtIndex:cell.indexPath.item];
    
    [self.collectionView reloadData];
    
    
    
    DDFunc;
    
}


#pragma mark -
#pragma mark -- UIImagePickerControllerDelegate
// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.



//选中图片时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    
    
    DDLogDebug(@"%@",info);
    //1. 取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if ((imageData.length /1024.0/1024.0) > 7) {


        NSLog(@"%f",(imageData.length/1024.0/1024.0));


        JGProgressHUD *progressHUB = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleLight];

        progressHUB.indicatorView = [[JGProgressHUDIndicatorView alloc]init];

        progressHUB.textLabel.text = @"图片大小超出7M 请重新选择";

        [progressHUB showInView:[UIApplication sharedApplication].keyWindow animated:YES];
        [progressHUB dismissAfterDelay:1.0 animated:YES];

        return;

    }
    
    
    
    
    
    
    //2. 保存图片
    [self.images addObject:image];
    
    //3. 刷新数据
    [self.collectionView reloadData];
  
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.images.count-1 inSection:1];
//
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//
    
    
    

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

//点击取消按钮调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}




#pragma mark -
#pragma mark -- 初始化item 相关属性

- (void)viewWillLayoutSubviews{
    
    //初始化每一个item 相关属性

    //边距
    CGFloat margin = 10;
    //设置水平间隙
    
    self.flowlayout.minimumInteritemSpacing = margin;

    
    //设置垂直间隙
    
    self.flowlayout.minimumLineSpacing = margin;
    
    //设置全局间隙
    
   
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
    
    //设置全局item size
                   
    //定义每一行需要显示的item 个数
    //列数
    
    NSInteger column = 3;
    
    
    //计算item size
 
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - (column+1)*margin)/(column*1.0);
    
    CGFloat itemHeignt = itemWidth;
    
    //CGFloat width = (self.view.mj_w - ((col +1) * 10)) / col;
    self.flowlayout.itemSize = CGSizeMake(itemWidth, itemHeignt);
    

    
    
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CEPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    // Configure the cell
    
    //设置数据
    //indexPath.item NSUInteger 0-1 = 18446744073709551615
    
    // 第一次count=0 item = 0 第二次count = 1 item = 0，1
    // 相当于让最后一个item 图片显示加号
    if (self.images.count == indexPath.item) {
        
        cell.iconImage = nil;
        
    }else{
        
        cell.iconImage = self.images[indexPath.item];
        cell.indexPath = indexPath;
        
        
    }
    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
