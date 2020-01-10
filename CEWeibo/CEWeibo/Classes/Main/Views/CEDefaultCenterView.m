//
//  CEDefaultCenterView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEDefaultCenterView.h"

#define nibName @"CEDfaultCenterView"

@interface CEDefaultCenterView ()




@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *descriptionIcon;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
//定时器
@property (strong, nonatomic) CADisplayLink *displayLink;

@end


@implementation CEDefaultCenterView



+ (instancetype)defaultCenterView{
    
    
    //取出xib 中的view
    
    CEDefaultCenterView *view = [[[NSBundle mainBundle]loadNibNamed:@"CEDfaultCenterView" owner:nil options:nil]lastObject];
    
    
    return view;
    
    
}


#pragma mark -
#pragma mark -- 设置转盘图片的名称


- (void)setBackgroundimgName:(NSString *)backgroundimgName{
    
    _backgroundimgName = [backgroundimgName copy];
    
    self.backgroundImg.image = [UIImage imageNamed:_backgroundimgName];
    
}

#pragma mark -
#pragma mark -- 设置中间图片信息


- (void)setDescriptionIconName:(NSString *)descriptionIconName{
    
    _descriptionIconName = [descriptionIconName copy];
    
    self.descriptionIcon.image = [UIImage imageNamed: _descriptionIconName];
    
    
}


#pragma mark -
#pragma mark -- 设置描述内容信息

- (void)setInfo:(NSString *)info{
    
    
    _info = [info copy];
    
    self.infoLbl.text = _info;
    
    
}





#pragma mark -
#pragma mark -- 注册按钮事件
- (IBAction)signIn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(defaultCenterView:didClickSignInBtn:)]) {
        
        [self.delegate defaultCenterView:self didClickSignInBtn:sender];
        
    }
    
    
    
}




#pragma mark -
#pragma mark -- 登陆按钮事件

- (IBAction)login:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(defaultCenterView:didClickLogInBtn:)]) {
        
        [self.delegate defaultCenterView:self didClickLogInBtn:sender];
        
    }
    
    
    
    
}



- (void)startRotate{
    
    
    //1.创建定时器
    //1秒60次
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    
    
    self.displayLink = link;
    //2.开时定时器
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
    
    
    
    
    
}

- (void)stopRotate{
    
    
    //1.停止计时器
    
    [self.displayLink invalidate];
    
    self.displayLink = nil;
    
    
    
    
}

- (void)update{
    
    self.backgroundImg.transform = CGAffineTransformRotate(self.backgroundImg.transform, M_PI/500);
    
    
}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
