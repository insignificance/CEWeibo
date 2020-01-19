//
//  CECollectionVC.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/18.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CECollectionVC : UICollectionViewController


/*给外部获取 配图的属性 */
@property (nonatomic,strong,readonly) NSMutableArray *images;

@end

NS_ASSUME_NONNULL_END
