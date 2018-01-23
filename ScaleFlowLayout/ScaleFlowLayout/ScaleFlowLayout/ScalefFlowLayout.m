//
//  ScalefFlowLayout.m
//  ScaleFlowLayout
//
//  Created by luodaji on 2018/1/22.
//  Copyright © 2018年 lkw. All rights reserved.
//

#import "ScalefFlowLayout.h"

@implementation ScalefFlowLayout


-(void)prepareLayout
{
    [super prepareLayout];
    NSLog(@"%s",__func__);
    // 让第一个item以及最后一个item居中
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}


/**
 返回每个item的布局属性

 @param rect 当前的矩形框内的布局
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
    NSArray<UICollectionViewLayoutAttributes *> *attriArray = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];// 没有copy的话，会报警告
    // 1.获取collectionview的中心点X的值
    CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 2.遍历每个item的布局属性，将每个item的中心点与collectionViewCenterX做比较
    for (UICollectionViewLayoutAttributes *attribute in attriArray) {
        // 2.1 计算每个item的中心点距离collectionViewCenterX的差值
        CGFloat deltaX = ABS(attribute.center.x - collectionViewCenterX);
        // 2.2 计算缩放系数，距离collectionViewCenterX越远的，就越小。这个自己看情况调整
        CGFloat scale = 1 - deltaX / self.collectionView.frame.size.width;
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return attriArray;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 collectionview滑动停止时，返回collectionview的偏移量。松手的那一刻调用

 @param proposedContentOffset 滑动停止时的偏移量
 @param velocity 速率
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 1.因为滑动的时候，collectionview有惯性，所以要获取最终collectionview的布局属性
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    NSArray<UICollectionViewLayoutAttributes *> *attriArray = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    // 2.因为滑动的时候，collectionview有惯性，所以要获取最终collectionview的中心点X的值
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 3.遍历每个item的布局属性，将每个item的中心点与collectionViewCenterX做比较，计算距离collectionViewCenterX最近的item
    CGFloat deltaMinX = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *attribute in attriArray) {
        if (ABS(deltaMinX) > ABS(attribute.center.x - collectionViewCenterX)) {
            deltaMinX = attribute.center.x - collectionViewCenterX;
        }
    }
    
    proposedContentOffset.x += deltaMinX;
    return proposedContentOffset;
}

@end
