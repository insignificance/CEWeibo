//
//  CEComposeToolbar.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/17.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEComposeToolbar.h"

@implementation CEComposeToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.backgroundColor = [UIColor lightGrayColor];
               
               // 创建5个按钮
               [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:CEComposeToolbarButtonTypeCamera];
               [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:CEComposeToolbarButtonTypeMention];
               [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:CEComposeToolbarButtonTypeTrend];
               [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:CEComposeToolbarButtonTypeEmotion];
               [self setupBtn:@"compose_keyboardbutton_background" highImage:@"compose_keyboardbutton_background_highlighted" tag:CEComposeToolbarButtonTypeAdd];
           }
           return self;
        
    
}


/**
 * 创建一个按钮
 */
- (void)setupBtn:(NSString *)image highImage:(NSString *)highImage tag:(int)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:btn];
}


- (void)btnClick:(UIButton *)btn
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickBtnType:)]) {
        [self.delegate composeToolbar:self didClickBtnType:(int)btn.tag];
    }
}


- (void)layoutSubviews{
    
    
    //；调整五个按钮的frame
    
    NSUInteger count = self.subviews.count;
    CGFloat width = self.mj_w / count;
    
    
    for (int i = 0; i<count; i++) {
        
        UIButton *btn = self.subviews[i];
        btn.mj_h = self.mj_h;
        btn.mj_w = width;
        btn.mj_y = 0;
        btn.mj_x = i * width;
        
    }

}





@end
