//
//  CEBarcodeVC.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/12.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEBarcodeVC.h"
#import <CFAlertViewController-Swift.h>
#import <AVFoundation/AVFoundation.h>


#define barcodeLineHeight self.barcodeline.frame.size.height

@interface CEBarcodeVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *barcodeline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstaint;
@property (strong,nonatomic) AVCaptureSession *session;

@end

@implementation CEBarcodeVC





-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.topConstaint.constant = -barcodeLineHeight;
 
    /*
     
     设置Navigation bar

     */
    
    [self setUpNavigationBar];
    
    
    [self setUpNavigationItem];
    
    
 

    //去掉navigationBar 底部黑线
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
//    [self.navigationController.navigationBar setShadowImage:nil];
//如果不设置BackgroundImage 系统会自动添加一个 _UIVisualEffectBackdropView
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
 //[self.navigationController.navigationBar setTranslucent:NO];
 
//    1. setBackgroundColor:UIColor.clearColor
//    2. setBarTintColor:UIColor.clearColor
//    3. setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]
//    4. setShadowImage:[UIImage new] size:CGSizeMake(SCREEN_WIDTH, 0.01f)]


}


/*
 - (void)viewWillLayoutSubviews{
 
 [super viewWillLayoutSubviews];
 
 //去除黑条
 //self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
 
 
 DDFunc;
 
 __block int index = 0;
 
 [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 
 
 if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
 
 index++;
 obj.hidden = YES;
 
 
 
 }
 
 
 }];
 
 DDLogDebug(@"index = %d",index);
 
 
 
 }
 
 
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatetopConstraints)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
    
    if (TARGET_IPHONE_SIMULATOR) {
          
          //禁用扫描
          self.barcodeline = nil;
          
          CFAlertViewController *alertController =[CFAlertViewController alertControllerWithTitle:@"无法连接相机" message:@"" textAlignment:NSTextAlignmentCenter preferredStyle:CFAlertControllerStyleAlert didDismissAlertHandler:nil];
         
          
          CFAlertAction *destructivecAction = [CFAlertAction actionWithTitle:@"取消" style:CFAlertActionStyleDestructive alignment:CFAlertActionAlignmentJustified backgroundColor:[UIColor redColor] textColor:[UIColor blackColor]handler:nil];
          
          
          [alertController setHeaderView:[UIView new]];
          
          [alertController addAction:destructivecAction];
          
          [self presentViewController:alertController animated:YES completion:nil];
          
          
          
      }else if (TARGET_OS_IPHONE){
          
          
          [self scanQR];
          
      }
      
    
    
  
    
}

#pragma mark -
#pragma mark -- 更新扫描仪顶部约束

- (void)updatetopConstraints{
    
    self.topConstaint.constant +=5;
    if (self.topConstaint.constant >= barcodeLineHeight) {
        
        self.topConstaint.constant = -barcodeLineHeight;
        
    }
 
}


#pragma mark -
#pragma mark -- 设置导航条属性


- (void)setUpNavigationBar{
    
    //设置导航栏 阴影
    
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor orangeColor] CGColor];
    
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8;
    
    self.navigationController.navigationBar.layer.shadowRadius  = 3;
    
    
    
    //设置title
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18];
    
    NSDictionary *dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName: [UIColor orangeColor]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    //设置按钮 颜色
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    
    //设置navigationbar 背景颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    /*
           The back indicator image is shown beside the back button.
           The back indicator transition mask image is used as a mask for content during push and pop transitions
           Note: These properties must both be set if you want to customize the back indicator image.
           */
     //佛系解决切换控制器黑条
     [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage new]];
      
    
    
    
    
    
}



#pragma mark -
#pragma mark -- 设置内容属性


- (void)setUpNavigationItem{
    
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
       
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photo:)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.rightBarButtonItem = photoButton;
       
       
       
    
    
    
}


#pragma mark -
#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
//只要解析到了数据就会调用

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    DDFunc;
    
    
    
}


- (void)scanQR{
    
    
    
    
    // 1. 获取输入设备
#warning 注意，获取输入设备一定要通过default 方法获取
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 根据输入设备创建输入对象
    
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:inputDevice error:NULL];
    
    // 3.创建输出对象
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    
    
    // 4. 设置输出对象的代理
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    
    // 5. 创建会话
    
    
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
#warning 由于输入和输出对象不能重复添加,所以在添加之前得闲判断是否可以添加
    
    // 6. 将输入和输出添加到会话中
    
    if ([session canAddInput:input]) {
        
        [session addInput:input];
        
    }
    
    if ([session canAddOutput:output]){
        
        [session addOutput:output];
        
    }
    
#warning 注意: 设置数据类型一定要在输入对象添加到会话以后再设置
    // 7. 设置输出的数据类型
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    
    //8.开始采集数据
#warning 扫描是一个很持久的操作 所以session 不能是局部变量
    
    self.session = session;
    
    [session startRunning];
    
    
    
    
    
    
}











- (void)close:(UIBarButtonItem *)btn{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    DDFunc;
    
    
}

- (void)photo:(UIBarButtonItem *)btn{
    
    DDFunc;
    
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
