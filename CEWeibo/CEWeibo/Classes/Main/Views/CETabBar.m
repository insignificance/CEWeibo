//
//  CETabBar.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/10.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CETabBar.h"



@interface CETabBar ()

/*
 
  TabBar 中的加号按钮
 
*/
@property (nonatomic,weak) UIButton *addButton;
@end

@implementation CETabBar




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



#pragma mark -
#pragma mark -- 指定初始化方法

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        //DDLogDebug(@"%s",__func__);
        //设置addBtn
        [self setUpAddBtn];
        
       // DDLogDebug(@"self.addButton = %@ %s",self.addButton,__func__);
        
    
        


    }
    return self;

}




#pragma mark -
#pragma mark -- 设置addButton

- (void)setUpAddBtn{
    
    
    
    UIButton *addButton = [[UIButton alloc]init];
    self.addButton = addButton;
    
    
    [self addSubview:addButton];

    [self.addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"]forState:UIControlStateNormal];
    
    
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    
    
    [self.addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    
    
    [self.addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
          
    
    
}




- (void)layoutSubviews{
    
    [super layoutSubviews];
    

    //tabBar 索引
     NSUInteger index = 0;
    //重新计算子控件中 tabBar 的frame
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = self.frame.size.width / 5.0;
    CGFloat H = self.frame.size.height;

    for (UIView *subView in self.subviews) {
        
       //UITabBarButton 私有不可直接获取
       //DDLogDebug(@"%@ superClass = %@",subView,subView.superclass);
        
       //方式 1. 获取父类 通过多态间接获取
       //方式 2. NSClassFromString(@"UITabBarButton"); //可精确定位
       //方式 3. 为其它空间设置tag 值
     if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //如果取到第三个 则 索引加一
            if (index == 2) {
                
                index ++;
            }
                      
            
            //动态计算X
            X = index * W;
            //DDLogDebug(@"%d %f",__LINE__,X);
          
            
            subView.frame = CGRectMake(X, Y, W, H);
            
       
            //当取到UITabBarButton 对象时 下标索引加一
            index++;
            
        }
     
      
    }
    
   
//设置addBtn frame

//此处不能用autolayout addButton 是添加到UITabBarItem 上的 而 UITabBarItem 不继承自UIView

    
//    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        //make.size.equalTo(self);
//        make.center.equalTo(self);
//
//
//    }];
    
    CGRect originalframe = self.addButton.frame;
    
    originalframe.size = self.addButton.currentBackgroundImage.size;
    
    CGFloat  centerX = self.frame.size.width*0.5;
    CGFloat centerY = self.frame.size.height*0.5;

    self.addButton.frame = originalframe;
    
    self.addButton.center = CGPointMake(centerX, centerY);
    
    // self(TabBar) 的参考系是 整个屏幕
    // self.addBtn 的参考系应该是 self(TabBar)
    // 参考系不同所以不能直接赋值
    // self.addButton.center = self.center;
    //DDLogDebug(@"self.frame = %@",NSStringFromCGRect(self.frame));
    //DDLogDebug(@"self.center = %@",NSStringFromCGPoint(self.center));
    
    //DDLogDebug(@"self.addButton.frame = %@ %s",self.addButton,__func__);
    //DDLogDebug(@"self.addButton.center = %@",NSStringFromCGPoint(self.addButton.center));
    
    
    
    
    
    
    
}


@end
