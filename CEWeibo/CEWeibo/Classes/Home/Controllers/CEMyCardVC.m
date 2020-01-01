//
//  CEMyCardVC.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/1.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEMyCardVC.h"
#import "JMGenerateQRCodeUtils.h"

@interface CEMyCardVC ()
@property (weak, nonatomic) IBOutlet UIImageView *MyCard;

@end

@implementation CEMyCardVC



 /**
  *  @brief 生成一张普通的二维码
  *
  *  @param string       传入你要生成二维码的数据
  *  @param imageSize    生成的二维码图片尺寸
  *
  *  @return UIImage
  */

 /*

 + (UIImage *)jm_generateQRCodeWithString:(NSString *)string
                                imageSize:(CGSize)imageSize;

 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.MyCard.image = [JMGenerateQRCodeUtils jm_generateQRCodeWithString:@"CEWeibo" imageSize:CGSizeMake(260, 260) logoImageName:@"Small" logoImageSize:CGSizeMake(58, 58)];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    
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
