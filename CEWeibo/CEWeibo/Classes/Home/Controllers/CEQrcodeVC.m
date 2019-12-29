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

    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18];

    NSDictionary *dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
   
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建定时器
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatetopConstraint)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
   
    self.topConstraint.constant = -scanlinHeight;
    
    
    
    
}

- (void)updatetopConstraint{
    
    self.topConstraint.constant +=5;
    if (self.topConstraint.constant >= scanlinHeight) {
        self.topConstraint.constant = -scanlinHeight;
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

@end
