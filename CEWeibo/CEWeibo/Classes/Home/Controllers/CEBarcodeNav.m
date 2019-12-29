//
//  CEBarcodeNav.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/12.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEBarcodeNav.h"

@interface CEBarcodeNav ()

@end

@implementation CEBarcodeNav


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   

    
}


//应该放在这里 视图是懒加载的不能 放在 viewdidLoad 等方法里

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.tabBarItem.image = [UIImage imageNamed:@"qrcode_tabbar_icon_barcode"];
       
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"qrcode_tabbar_icon_barcode_highlighted"];
       
    
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
