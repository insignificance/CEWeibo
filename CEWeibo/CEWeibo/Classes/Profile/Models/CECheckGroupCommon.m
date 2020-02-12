//
//  CECheckGroupCommon.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CECheckGroupCommon.h"
#import "CECheckCommonItem.h"


@implementation CECheckGroupCommon




- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    // 1.遍历所有的行
    for (int i = 0; i < self.items.count; i++) {
        // 取出对应行的模型
        CECheckCommonItem *item = self.items[i];
        // 判断当前遍历的行是否是需要选中的行
        if (i == _currentIndex) {
            // 设置当前行为选中
            item.check = YES;
        }else
        {
            item.check = NO;
        }
    }
}



@end
