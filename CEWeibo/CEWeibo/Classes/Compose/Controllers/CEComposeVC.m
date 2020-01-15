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


@end

@implementation CEComposeVC



- (void)loadView{
    
    [super loadView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航条的标题/及左右按钮
    
    self.navigationItem.title = @"发送微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送微博" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    
    
    
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

#pragma mark -
#pragma mark -- 关闭按钮

- (void)close{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark -
#pragma mark -- 发送按钮


- (void)compose{
    
    
    
    
}


#pragma mark -
#pragma mark -- UITextViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //滑动控件关闭键盘
    [self.view resignFirstResponder];
    
    
    
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    
    self.inputTextView.placeholder = @"";
    
    
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
