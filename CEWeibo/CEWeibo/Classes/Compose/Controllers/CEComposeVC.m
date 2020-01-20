//
//  CEComposeVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/15.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEComposeVC.h"
#import "CEInputTextView.h"
#import "CEComposeToolbar.h"
#import "CECollectionVC.h"


@interface CEComposeVC ()<UITextViewDelegate,CEComposeToolbarDelegate>

/*自定义输入框*/
@property (nonatomic,weak)CEInputTextView *inputTextView;
@property (nonatomic,strong)JGProgressHUD *hub;
/*自定义工具条*/
@property (nonatomic,weak)CEComposeToolbar *toolBar;
/*输入框容器*/
@property (weak, nonatomic) IBOutlet UIView *inputViewContainer;

/*segue 获取到的 collectionview*/
@property (strong,nonatomic) CECollectionVC *collectionvc;


@end

@implementation CEComposeVC



- (void)loadView{
    
    [super loadView];
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // 1. 设置导航条的标题/及左右按钮
    
    [self setUpNav];
    
    
    // 2. 设置自定义输入框
    
    
    [self setUpInput];
    
    
    // 3. 设置工具条
    
    [self setUpToolBar];
    
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:animated];
    
    
    
    
}


#pragma mark -
#pragma mark -- 设置导航栏

- (void)setUpNav{
    
    
    
    self.navigationItem.title = @"发送微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    
    
    //默认发送微博按钮禁用
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
}


#pragma mark -
#pragma mark -- 设置自定义输入框

- (void)setUpInput{
    
    
    
    /*
     输入框：
     
     1.提醒文本
     
     2.可以输入内容
     
     3.可以换行
     
     4.可以滚动
     
     */
    
    //2. 创建输入控件
    
    CEInputTextView *inputTextView = [[CEInputTextView alloc]init];
    
    inputTextView.frame = self.inputViewContainer.frame;
    
    //默认情况下(内容未填满)textview 是不能滚动的 但是可以通过设置属性 使其默认可以滚动
    
    inputTextView.alwaysBounceVertical = YES;
    
    inputTextView.placeholder = @"分享感兴趣的内容......";
    
    inputTextView.delegate = self;
    
    
    self.inputTextView = inputTextView;
    
    [self.inputViewContainer addSubview:inputTextView];
    
    
    
}


#pragma mark -
#pragma mark -- 设置工具条

- (void)setUpToolBar{
    
    
    
    //3. 创建自定义工具条
    
    CEComposeToolbar *toolBar  = [[CEComposeToolbar alloc]init];
    
    toolBar.frame = CGRectMake(0, self.view.mj_h - 44, self.view.mj_w, 44);
    //设置代理
    toolBar.delegate = self;
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
    
    
    //监听键盘的弹出和受气
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification  object:nil];
    
    
    
    //方案2.
    
    //self.inputTextView.inputAccessoryView = toolBar;
    
    
    
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
#pragma mark -- 关闭按钮

- (void)close{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark -
#pragma mark -- 发送按钮


- (void)compose{
    
    //若有配图
    if (self.collectionvc.images >0) {
        
        [self composeStatusWithImg];
        
    }else{
        
        [self composeStatusWithText];
        
    }
    
    
    
}



#pragma mark -
#pragma mark -- 发送文字微博

- (void)composeStatusWithText{
    
    //创建网络管理者
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //封装请求参数
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    
    parameters[@"access_token"] = account.access_token;
    
    //parameters[@"status"] = self.inputTextView.text;
    
    
    parameters[@"status"] = [NSString stringWithFormat:@"%@ http://www.baidu.com/",self.inputTextView.text];
    
    NSString *urlString = @"https://api.weibo.com/2/statuses/share.json";
    
    //处理status 参数
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
    
    //发送请求
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogDebug(@"发送成功");
        
        //关闭键盘
        [self.inputTextView resignFirstResponder];
        
        //关闭当前视图
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            
            
            self.hub.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc]init];
            //显示发送成功提示
            self.hub.textLabel.text  = @"发送成功";
            
            [self.hub showInView:[UIApplication sharedApplication].keyWindow animated:YES];
            
            [self.hub dismissAfterDelay:0.5 animated:YES];
            
            
            
        }];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogDebug(@"发送失败");
        
        DDLogDebug(@"%@",error);
        
        //显示发送失败提示
        
        self.hub.indicatorView = [[JGProgressHUDErrorIndicatorView alloc]init];
        //显示发送成功提示
        self.hub.textLabel.text  = @"发送失败";
        
        [self.hub showInView:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [self.hub dismissAfterDelay:0.5 animated:YES];
        
        
        
    }];
    
    
}

#pragma mark -
#pragma mark -- 发送文字图片微博

- (void)composeStatusWithImg{
    
    
    //创建网络管理者
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //封装请求参数
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    
    parameters[@"access_token"] = account.access_token;
    
    //parameters[@"status"] = self.inputTextView.text;
    
    
    parameters[@"status"] = [NSString stringWithFormat:@"%@ http://www.baidu.com/",self.inputTextView.text];
    
    NSString *urlString = @"https://api.weibo.com/2/statuses/share.json";
    
    //处理status 参数
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
    
    
    //发送请求
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        /**
         参数1: 需要上传的二进制数据
         参数2: 服务器参数的名称pic
         参数3: 文件名称(画用于服务器保存)
         参数4:文件类型
         */
        
        // 接口限制只能传一张
        UIImage *image = [self.collectionvc.images firstObject];
        

        NSLog(@"%@",[NSThread currentThread]);
        
        //处理图片大小
//
//        __block NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//
//        //若大于5m
//        if (imageData.length/1024 > (5.0*1024)) {
//
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//               imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:5.0];
//
//            });
//        }
//
        //NSData *imageData = UIImagePNGRepresentation(image);
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
 
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"abc" mimeType:@"image/png"];
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogDebug(@"发送成功");
        
        //关闭键盘
        [self.inputTextView resignFirstResponder];
        
        //关闭当前视图
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            
            
            self.hub.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc]init];
            //显示发送成功提示
            self.hub.textLabel.text  = @"发送成功";
            
            [self.hub showInView:[UIApplication sharedApplication].keyWindow animated:YES];
            
            [self.hub dismissAfterDelay:0.5 animated:YES];
            
            
            
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        DDLogDebug(@"发送失败");
        
        DDLogDebug(@"%@",error);
        
        //显示发送失败提示
        
        self.hub.indicatorView = [[JGProgressHUDErrorIndicatorView alloc]init];
        //显示发送成功提示
        self.hub.textLabel.text  = @"发送失败";
        
        [self.hub showInView:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [self.hub dismissAfterDelay:0.5 animated:YES];
        
        
        
    }];
    
    
    
    
    
    
    
    
}






#pragma mark -
#pragma mark -- UITextViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //滑动控件关闭键盘
    [self.inputTextView resignFirstResponder];
    
    DDFunc;
    
    
    
}


- (void)textViewDidChange:(UITextView *)textView{
    
    
    //DDLogDebug(@"textViewDidChange");
    
    
    self.navigationItem.rightBarButtonItem.enabled = (textView.text.length >0);
    
    
    
}


#pragma mark -
#pragma mark -- CEComposeToolbarDelegate

- (void)composeToolbar:(CEComposeToolbar *)toolbar didClickBtnType:(CEComposeToolbarButtonType)type{
    
    
    DDLogDebug(@"%d",type);
    
}


#pragma mark -
#pragma mark -- notification


-(void)keyBoardWillShow:(NSNotification *)noti{
    
    
    /**
     {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 260}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 797}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 537}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 260}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 407}, {375, 260}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     
     */
    
    //1. 取出键盘的frame
    
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //取出键盘的高度
    
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    
    //2. 获取键盘弹出时间
    
    CGFloat time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] ;
    
    
    //3. 设置工具条的Y值 向上移动键盘的高度
    //
    //    [UIView animateWithDuration:time animations:^{
    //
    //
    //        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    //
    //
    //    }];
    
    
    NSInteger curve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    
    [UIView animateWithDuration:time delay:0.0 options:curve<<16 animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    } completion:nil];
    
    
    
    DDLogDebug(@"%@",noti.userInfo);
    
    
    
}

-(void)keyBoardWillHide:(NSNotification *)noti{
    
    
    //1. 获取键盘弹出时间
    
    CGFloat time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] ;
    
    [UIView animateWithDuration:time delay:0 options:7<<16 animations:^{
        
        self.toolBar.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    
    
    
    DDLogDebug(@"%@",noti.userInfo);
    
}





#pragma mark -
#pragma mark --

- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    
    
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    CECollectionVC *collectionVC = segue.destinationViewController;
    
    self.collectionvc = collectionVC;
    
    
    
    
    
}

#pragma mark -
#pragma mark -- 压缩图片到指定大小

/**
 
 *  压缩图片到指定文件大小

 *  @param image 目标图片
 
 *  @param size 目标大小（最大值）

 *  @return 返回的图片文件
 
 */


- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    CGFloat dataKBytes = data.length/1024.0;
    
    CGFloat maxQuality = 0.9f;
    
    CGFloat lastData = dataKBytes;
    
  while (dataKBytes > size && maxQuality > 0.01f) {
        
        maxQuality = maxQuality - 0.01f;
        
        data = UIImageJPEGRepresentation(image, maxQuality);
        
        dataKBytes = data.length / 1024.0;
        
        if (lastData == dataKBytes) {
            
            break;
            
        }else{
            
            lastData = dataKBytes;
            
        }
        
    }
    
    return data;
    
    
}




@end

