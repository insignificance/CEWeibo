//
//  CEColPhotoCell.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/21.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEColPhotoCell.h"
#import "CEPhoto.h"

@interface CEColPhotoCell()

//图片容器
@property (weak, nonatomic) IBOutlet UIView *photoView;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

//gif图标
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;




@end


@implementation CEColPhotoCell


- (void)setPhoto:(CEPhoto *)photo{
    
    _photo = photo;
    
    NSURL *imageUrl = [NSURL URLWithString:_photo.thumbnail_pic];
    
    // DDLogDebug(@"imageUrl = %@",imageUrl);
    
    
    //判断是否是gif 动图
    //
    //[imageUrl.absoluteString.pathExtension.lowercaseString isEqualToString:@"gif"];
    if ([imageUrl.absoluteString.lowercaseString hasSuffix:@".gif"]) {
        
        self.gifImageView.hidden = NO;
        
    }else{
        
        
        self.gifImageView.hidden = YES;
        
    }
 
    //下载图片
    [self.photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"compose_trendbutton_background"]];
     
   
  
    
}





@end
