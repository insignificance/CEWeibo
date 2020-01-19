//
//  CEPhotoCell.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/18.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEPhotoCell.h"



@interface CEPhotoCell ()

@property (weak, nonatomic) IBOutlet UIButton *addPhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletePhotoBtn;


@end


@implementation CEPhotoCell

- (IBAction)didClickAddBtn:(UIButton *)sender {
    
    DDFunc;
    
    //发送添加的通知
    
    [[NSNotificationCenter defaultCenter]postNotificationName:CEAddPhotoNotification object:self];
    
    
    
    
    
}
- (IBAction)didClickDeleteBtn:(UIButton *)sender {
    
    DDFunc;
    //发送删除的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:CEDeletePhotoNotification object:self];
    
    
}


-(void)setIconImage:(UIImage *)iconImage{
    
    _iconImage = iconImage;
    
    if (iconImage) {
        
        //若存在
        self.deletePhotoBtn.hidden = NO;
        self.addPhotoBtn.userInteractionEnabled = NO;
        
        [self.addPhotoBtn setBackgroundImage:_iconImage forState:UIControlStateNormal];
           
        
    }else{
        
        //若不存在
        //隐藏delebtn
        self.deletePhotoBtn.hidden = YES;
        
        self.addPhotoBtn.userInteractionEnabled = YES;
        
        //设置占位图片 //如果不设置 会出现 复用缓存问题
        
        [self.addPhotoBtn setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        
        [self.addPhotoBtn setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
        
        
        
        
        
    }
    
   
    
    
    
}



@end
