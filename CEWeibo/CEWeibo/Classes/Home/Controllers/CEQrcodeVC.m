//
//  CEQrcodeVC.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/12.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEQrcodeVC.h"
#define scanlinHeight self.scanline.frame.size.height

@interface CEQrcodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *scanline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation CEQrcodeVC



-(void)awakeFromNib{
    
    
    [super awakeFromNib];

    /*
    
    设置Navigation bar
    
    
    */

    [self setUpNavigationBar];
    
    [self setUpNavigationItem];

    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建定时器
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatetopConstraint)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
   
    self.topConstraint.constant = -scanlinHeight;
    
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
