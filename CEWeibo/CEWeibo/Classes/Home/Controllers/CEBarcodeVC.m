//
//  CEBarcodeVC.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/12.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "CEBarcodeVC.h"

#define barcodeLineHeight self.barcodeline.frame.size.height

@interface CEBarcodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *barcodeline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstaint;

@end

@implementation CEBarcodeVC


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
    
    
    self.topConstaint.constant = -barcodeLineHeight;
    
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatetopConstraints)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
    
}


- (void)updatetopConstraints{
    
    self.topConstaint.constant +=5;
    if (self.topConstaint.constant >= barcodeLineHeight) {
        
        self.topConstaint.constant = -barcodeLineHeight;
        
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
