//
//  CEHomeViewController.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEHomeViewController.h"
#import "CEScannerController.h"
#import "CETitleView.h"
#import <XHPopMenu/XHPopMenu.h>





@interface CEHomeViewController ()

@property (nonatomic,weak)CETitleView *cetitleView;

@end

@implementation CEHomeViewController


- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    
    if (self.defaultView != nil) {
        
        [self.defaultView startRotate];
        
    }
    

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    [self setUpImgAndTitle];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    
    [super viewWillDisappear:animated];
    
    if (self.defaultView != nil) {
        
        [self.defaultView stopRotate];
        
    }
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    
    if (self = [super initWithStyle:style]) {
        
        
        
        //设置BarButtonItem
        
        
        [self setUpBarButtonItem];
        
     
        //创建自定义titleview
        
        [self setUpTitleView:@"首页" andImage:@"navigationbar_arrow_down"];
        
        
        
        //设置默认view 的 图片 文字 应该延后
        
        //[self setUpImgAndTitle];
        
        
        
        
    }
    
    
    return self;
    
}



#pragma mark -
#pragma mark -- 设置默认view的图片 文字

- (void)setUpImgAndTitle{
    
    self.defaultView.backgroundimgName = @"visitordiscover_feed_image_smallicon";
    
    self.defaultView.info = @"当你关注一些人以后，他们发布的最新消息会显示在这里";
    
    self.defaultView.descriptionIconName = @"visitordiscover_feed_image_house";
    
    
    
}



#pragma mark -
#pragma mark -- 设置BarButtonItem


- (void)setUpBarButtonItem{
    
    
    //设置leftBarButton
         self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlightedImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(ClikLeftBarButton:)];
         //设置rightBarButton
         self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlightedImg:@"navigationbar_pop_highlighted" target:self action:@selector(ClickRightBarButton:)];
         
    
    
}




#pragma mark -
#pragma mark -- 创建自定义titleview

- (void)setUpTitleView:(NSString *)title andImage:(NSString *)image{
    
    UIButton *titleBtn = [[UIButton alloc]init];
    
    [titleBtn setTitle:title forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    
    UIImageView *accImgView = [[UIImageView alloc]init];
    accImgView.image = [UIImage imageNamed:image];
    
    [accImgView sizeToFit];
    
    CETitleView *titleView = [[CETitleView alloc]initWithBtn:titleBtn andImageView:accImgView];
    
    self.cetitleView = titleView;
    
    //设置内置按钮 文字颜色
    
    [titleView.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    //为内置按钮添加点击事件
    
    [titleView.button addTarget:self action:@selector(ClickTitleView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleView;
    
    //self.navigationItem.titleView.backgroundColor = [UIColor greenColor];
    
    
}







#pragma mark -
#pragma mark -- 点击titlView

- (void)ClickTitleView:(UIButton *)btn{
    
    
    
    //改变titleView 指示器图片
    [self changeIndicator];
    
    
    
    //创建 xhpopMenu
    NSMutableArray<__kindof XHPopMenuItem *> *tempArr = [NSMutableArray array];
    NSArray *titleArr = @[@"我", @"我的好友", @"科技", @"美食", @"热点", @"随便看看"];
    for (int i = 1; i < titleArr.count; i++) {
        XHPopMenuItem *model = [[XHPopMenuItem alloc] initWithTitle:titleArr[i - 1] image:nil block:^(XHPopMenuItem *item) {
            [self changeIndicator];
            NSLog(@"block:%@",item);
        }];
        
        
        [tempArr addObject:model];
    }
    
    XHPopMenuConfiguration *option = [XHPopMenuConfiguration defaultConfiguration];
    option.style = XHPopMenuAnimationStyleScale;
    option.maskBackgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    [option setDismissBlock:^{
        
        [self changeIndicator];
        
        
    }];
    
    //[XHPopMenu showMenuInView:nil withRect:CGRectMake(10, 20, 120, 40) menuItems:tempArr withOptions:option];
    
    [XHPopMenu showMenuWithView:self.cetitleView menuItems:tempArr withOptions:option];
    
    
    
    
    
    
    DDFunc;
    
}


#pragma mark -
#pragma mark -- 改变titleview 的图片

- (void)changeIndicator{
    
    
    self.cetitleView.click = !self.cetitleView.click;
    
    if (self.cetitleView.isClik) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cetitleView.imageView.image = [UIImage imageNamed:@"navigationbar_arrow_up"];
            
        }];
        
    }else{
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cetitleView.imageView.image = [UIImage imageNamed:@"navigationbar_arrow_down"];
            
        }];
        
        
        
    }
    
    
}


#pragma mark -
#pragma mark -- 点击左侧barbutton


- (void)ClikLeftBarButton:(UIButton *)btn{
    
    
    DDFunc;
    
}



#pragma mark -
#pragma mark -- 点击右侧barbutton

- (void)ClickRightBarButton:(UIButton *)btn{
    
    
    //DDFunc;
    //获取CEStoryboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CEStoryboard" bundle:nil];
    
    CEScannerController *scannerVc = [sb instantiateInitialViewController];
    
    [self presentViewController:scannerVc animated:YES completion:nil];
    
    
    
}


#pragma mark -
#pragma mark -- UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 20;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"];
        
        
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //DDFunc;
    
    
    
    
    
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    
    
    DDFunc;
    
    
}

@end
