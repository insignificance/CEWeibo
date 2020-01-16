//
//  CEComposeVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/15.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEComposeVC.h"
#import "CEInputTextView.h"


@interface CEComposeVC ()<UITextViewDelegate>

@property (nonatomic,weak)CEInputTextView *inputTextView;
@property (nonatomic,strong)JGProgressHUD *hub;


@end

@implementation CEComposeVC



- (void)loadView{
    
    [super loadView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
  


}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航条的标题/及左右按钮
    
    self.navigationItem.title = @"发送微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    
    
    //默认发送微博按钮禁用
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    /*
     输入框：
     
     1.提醒文本
     
     2.可以输入内容
    
     3.可以换行
     
     4.可以滚动
     
     */
    
    //2. 创建输入控件
    
    CEInputTextView *inputTextView = [[CEInputTextView alloc]init];
    
    inputTextView.frame = self.view.frame;
    
    //默认情况下(内容未填满)textview 是不能滚动的 但是可以通过设置属性 使其默认可以滚动
    
    inputTextView.alwaysBounceVertical = YES;
    
    inputTextView.placeholder = @"分享感兴趣的内容......";
        
    inputTextView.delegate = self;
    
    
  
    
    
    self.inputTextView = inputTextView;
    
    [self.view addSubview:inputTextView];
    


}


-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:animated];

    
    
    
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
#pragma mark -- UITextViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //滑动控件关闭键盘
    [self.view resignFirstResponder];
    
    
    
}


- (void)textViewDidChange:(UITextView *)textView{
    
    
    //DDLogDebug(@"textViewDidChange");
    
    
    self.navigationItem.rightBarButtonItem.enabled = (textView.text.length >0);
    
    
    
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
