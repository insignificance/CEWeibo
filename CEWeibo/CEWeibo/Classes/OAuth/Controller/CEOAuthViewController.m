//
//  CEOAuthViewController.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEOAuthViewController.h"
#import <ProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import <WebKit/WebKit.h>
#import <JGProgressHUD/JGProgressHUD.h>
#import "UIWindow+Extension.h"
#import "CEAccount.h"
#import "CEAccountTool.h"


//#define client_id @"3018889502"
//#define redirect_uri @"http://www.youku.com"
//#define secret @"8af3169367d05364544835dbf1598e40"
#define client_id @"2223713944"
#define redirect_uri @"http://www.youku.com"
#define secret @"2224f1cb88b3236a9039cd6cd607c5da"



@interface CEOAuthViewController ()<WKNavigationDelegate>

@property (nonatomic,strong)JGProgressHUD *hub;




@end

@implementation CEOAuthViewController




#pragma mark -
#pragma mark -- 重写loadView

- (void)loadView{
    
    self.view = [[WKWebView alloc]init];
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.hub.textLabel.text  = @"正在加载";
    
    [self.hub showInView:self.view animated:YES];
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //设置返回按钮
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    
    
    
    
    /*
     
     请求用户授权Token
     
     */
    
    
    //拼接url
    
    NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@",client_id,redirect_uri];
    
    //NSLog(@"str = %@ ",str);
    
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    WKWebView *webView = (WKWebView *)self.view;
    
    
    
    webView.navigationDelegate = self;
    
    
    [webView loadRequest:request];
    
    
    
    
    /*请求用户授权Token
     OAuth2/access_token    获取授权过的Access Token
     OAuth2/get_token_info    授权信息查询接口
     OAuth2/revokeoauth2    授权回收接口
     OAuth2/get_oauth2_token    OAuth1.0的Access Token更换至OAuth2.0的Access Token*/
    
    
    
    
    
    
    
    
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
#pragma mark -- 取消

- (void)cancel{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    DDFunc;
    
    
}




#pragma mark -
#pragma mark --利用货渠道的已经授权的RequestToken 获取授权过的Access Token
-(void)accessTokenWithCode:(NSString *)code{
    
    

    
    CENetWorkingTools *tools = [CENetWorkingTools shareNetworkTools];
    
    
    [tools loadAccessTokenWithCode:code success:^(CEAccount * _Nonnull account) {
        
        
        DDLogDebug(@"获取accesstoken 成功 %@",account);
        
        
        if (account) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                //判断应该显示新特性还是欢迎界面
                
                [[UIApplication sharedApplication].keyWindow chooseRootViewController];
                
                
            }];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        DDLogDebug(@"获取accesstoken 失败%@",error);
        
    }];
    

    
}



#pragma mark -
#pragma mark -- WKNavigationDelegate





- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
    
    DDFunc;
    
}



//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//
//
//     DDFunc;
//
//}

//
//-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences * _Nonnull))decisionHandler{
//    
//    
//    DDFunc;
//    
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    
    
    //放行
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSString *urlString = navigationAction.request.URL.absoluteString;
    
    NSRange range = [urlString rangeOfString:@"code="];
    
    
    if (range.location != NSNotFound) {
        
        NSUInteger index = range.location + range.length;
        
        NSString *code = [urlString substringFromIndex:index];
        
        
        
        // 利用获取到的以授权的requestoken 换取accesstoken
        [self accessTokenWithCode:code];
        
        
        
    }
    
    
    
    DDLogDebug(@"%@",navigationAction.request.URL.absoluteString);
    
    DDFunc;
    
}



- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    
    
    DDFunc;
    
    
    // [ProgressHUD show:@"正在加载" Interaction:YES];
    
}


//开始加载

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
    
    DDFunc;
    
    
    
    
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









/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
