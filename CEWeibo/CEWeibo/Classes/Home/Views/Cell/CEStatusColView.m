//
//  CEStatusColView.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/23.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatusColView.h"
#import "CEStatues.h"
#import "CEColPhotoCell.h"
#import <GKPhotoBrowser/GKPhotoBrowser.h>
#import "CEPhoto.h"

static NSString *reuseID = @"photoCell";
@interface CEStatusColView ()<UICollectionViewDelegate,UICollectionViewDataSource>



@end

@implementation CEStatusColView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -
#pragma mark -- UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    NSInteger count = self.statues.pic_urls.count;
 
    return count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取cell
    
    CEColPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];

    //设置数据
    
    CEPhoto *photo = self.statues.pic_urls[indexPath.row];
    cell.photo = photo;

    cell.photo = photo;
    
    //返回
    return cell;
    
    
    
    
}

#pragma mark -
#pragma mark -- UICollectionViewDelegate

//点击item 调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建浏览器
    //告诉浏览器需要显示哪些内容
    //告诉浏览器当前需要显示的索引
    //显示浏览器
    
    
    //1、创建包含GKPhoto的数组
    NSMutableArray *photos = [NSMutableArray new];
    [self.statues.pic_urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CEPhoto *phptoMode = obj;
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:phptoMode.bmiddle_pic];
        [photos addObject:photo];
    }];
    
    
    
    //2、创建GKPhotoBrowser并显示
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.row];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:[UIApplication sharedApplication].keyWindow.rootViewController];
    
    
    
    
    
    //3、自定义遮盖视图
    
    
    
    
}






@end
