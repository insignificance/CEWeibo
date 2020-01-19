//
//  CEPhotoCell.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/18.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CEAddPhotoNotification @"CEAddPhotoNotification"
#define CEDeletePhotoNotification @"CEDeletePhotoNotification"

NS_ASSUME_NONNULL_BEGIN

@interface CEPhotoCell : UICollectionViewCell
/*  接收外界传入的数据  */
@property (nonatomic,strong,nullable) UIImage *iconImage;
/* 赋值时传入的indexPath*/
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
