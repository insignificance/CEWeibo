//
//  CEQrcodeVC.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/12.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEQrcodeVC.h"
#import "CEWeibo-Bridging-Header.h"
#import <AVFoundation/AVFoundation.h>
#import <CFAlertViewController-Swift.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"



#define scanlinHeight self.scanline.frame.size.height

@interface CEQrcodeVC ()<AVCaptureMetadataOutputObjectsDelegate,AppdelegateDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *scanline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIView *scanView;//定位扫描框在哪个位置
@property ( strong , nonatomic ) AVCaptureDevice * device; //捕获设备，默认后置摄像头
@property ( strong , nonatomic ) AVCaptureDeviceInput * input; //输入设备
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;//输出设备，需要指定他的输出类型及扫描范围
@property ( strong , nonatomic ) AVCaptureSession * session; //AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * previewLayer;//展示捕获图像的图层，是CALayer的子类

@end

@implementation CEQrcodeVC



-(void)awakeFromNib{
    
    
    [super awakeFromNib];
    
    /*
     
     设置Navigation bar
     
     
     */
    
    [self setUpNavigationBar];
    
    [self setUpNavigationItem];
    
    
    
    //self.view.backgroundColor = [UIColor clearColor];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建定时器
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatetopConstraint)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.topConstraint.constant = -scanlinHeight;
    
    
    if (TARGET_IPHONE_SIMULATOR) {
        //弹出提示
        [self showMessage];
    }
    
    
    
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //显示tabbar
    self.tabBarController.tabBar.hidden = NO;
    
    //注意这里的判断
    if (!TARGET_OS_SIMULATOR){
        
        AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
        
        appDelegate.delegate = self;
        
        [self scanQR];
        
        DDFunc;
        
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
    [super viewWillDisappear:animated];
    
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    if ([self.session isRunning]) {
        
        [self.session stopRunning];
        
    }
    
    
    
}



#pragma mark -
#pragma mark -- 懒加载

//下面初始化AVCaptureSession和AVCaptureVideoPreviewLayer:
- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (_previewLayer == nil) {
        //负责图像渲染出来
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = self.view.bounds;
    }
    return _previewLayer;
}

/**
 这里设置输出设备要注意rectOfInterest属性的设置，一般默认是CGRect(x: 0, y: 0, width: 1, height: 1),
 全屏都能读取的，但是读取速度较慢。
 注意rectOfInterest属性的传人的是比例。
 比例是根据扫描容器的尺寸比上屏幕尺寸（注意要计算的时候要计算导航栏高度，有的话需减去）。
 参照的是横屏左上角的比例，而不是竖屏。
 所以我们再设置的时候要调整方向如下面所示。
 */
- (AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        //初始化输出设备
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        // 1.获取屏幕的frame
        CGRect viewRect = self.view.frame;
        // 2.获取扫描容器的frame
        CGRect containerRect = self.scanView.frame;
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        //rectOfInterest属性设置设备的扫描范围
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
    
    /**网上还有一种是根据AVCaptureInputPortFormatDescriptionDidChangeNotification通知设置的，也是可行的，自选一种即可
     __weak typeof(self) weakSelf = self;
     [[NSNotificationCenter defaultCenter]addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification * _Nonnull note) {
     if (weakSelf){
     //调整扫描区域
     AVCaptureMetadataOutput *output = weakSelf.session.outputs.firstObject;
     output.rectOfInterest = [weakSelf.previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanView.frame];
     }
     }];*/
}


- (AVCaptureDevice *)device{
    if (_device == nil) {
        // 设置AVCaptureDevice的类型为Video类型
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input{
    if (_input == nil) {
        //输入设备初始化
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}



- (void)scanQR{
    
    
    
    
    // 1. 获取输入设备
#warning 注意，获取输入设备一定要通过default 方法获取
    //AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 根据输入设备创建输入对象
    
    //AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:inputDevice error:NULL];
    
    // 3.创建输出对象
    
    //AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    
    
    // 4. 设置输出对象的代理
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    
    // 5. 创建会话
    
    
    // AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
#warning 由于输入和输出对象不能重复添加,所以在添加之前得闲判断是否可以添加
    
    // 6. 将输入和输出添加到会话中
    
    if ([self.session canAddInput:self.input]) {
        
        [self.session addInput:self.input];
        
    }
    
    if ([self.session canAddOutput:self.output]){
        
        [self.session addOutput:self.output];
        
    }
    
#warning 注意: 设置数据类型一定要在输入对象添加到会话以后再设置
    // 7. 设置输出的数据类型
    
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    
    // 8. 设置预览界面
    
   // AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    //previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    
    
    //9.开始采集数据
#warning 扫描是一个很持久的操作 所以session 不能是局部变量
    
    //self.session = session;
    
    [self.session startRunning];
    
    
    
    
    
    
}




/*
 - (void)viewWillLayoutSubviews{
 
 
 [super viewWillLayoutSubviews];
 
 
 
 //去除黑条
 self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
 
 
 [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 
 
 if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
 
 [obj removeFromSuperview];
 
 }
 
 
 }];
 
 
 }*/



#pragma mark -
#pragma mark -- 更新扫描仪顶部约束

- (void)updatetopConstraint{
    
    self.topConstraint.constant +=5;
    if (self.topConstraint.constant >= scanlinHeight) {
        self.topConstraint.constant = -scanlinHeight;
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
    
    
    
    
    
}



#pragma mark -
#pragma mark -- 设置内容属性


- (void)setUpNavigationItem{
    
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photo:)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.rightBarButtonItem = photoButton;
    
    
    
    
    
    
}



- (void)close:(UIBarButtonItem *)btn{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        //NSLog(@"%@",self);
        
        
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


#pragma mark -
#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
//只要解析到了数据就会调用

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    //    for (AVMetadataObject *current in metadataObjects) {
    //      if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
    //          && [_metadataObjectTypes containsObject:current.type]) {
    //        NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];
    //
    //        if (_completionBlock) {
    //          _completionBlock(scannedResult);
    //        }
    //
    //        break;
    //      }
    //    }
    
    AVMetadataObject *current = metadataObjects.lastObject;
    
    if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]] ) {
        
        [self.session stopRunning];
        
        NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *)current stringValue];
        
        DDLogDebug(@"%@",scannedResult);
        
        NSURL *url  = [NSURL URLWithString:scannedResult];
        
        //UIWebView *web = [UIWebView new];
        //WKWebView *web = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        
        
        
        [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
        
        // NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //[web loadRequest:request];
        
        //[self.view addSubview:web];
        
        
        
        
        
    }
    
    
    
    
    
    DDFunc;
    
    
    
}



#pragma mark -
#pragma mark -- AppdelegateDelegate

- (void)doSomeThing {
    [self scanQR];
}



- (void)dealloc{
    
    DDFunc;
    
}



#pragma mark -
#pragma mark -- 提示窗

- (void)showMessage{
    
    
    self.scanline = nil;
    
    CFAlertViewController *alertController =[CFAlertViewController alertControllerWithTitle:@"无法连接相机" message:@"" textAlignment:NSTextAlignmentCenter preferredStyle:CFAlertControllerStyleAlert didDismissAlertHandler:nil];
    
    
    CFAlertAction *destructivecAction = [CFAlertAction actionWithTitle:@"取消" style:CFAlertActionStyleDestructive alignment:CFAlertActionAlignmentJustified backgroundColor:[UIColor redColor] textColor:[UIColor blackColor]handler:nil];
    
    
    [alertController setHeaderView:[UIView new]];
    
    [alertController addAction:destructivecAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}

@end
