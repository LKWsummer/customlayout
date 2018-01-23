//
//  ViewController.m
//  ScaleFlowLayout
//
//  Created by luodaji on 2018/1/22.
//  Copyright © 2018年 lkw. All rights reserved.
//

#import "ViewController.h"
#import "TheCollectionViewCell.h"
#import "ScalefFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource>

@end

static NSString *const identifier = @"identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScalefFlowLayout *layout = [[ScalefFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(150, 300);
    
    CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TheCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    // 中心线
    CGFloat x = self.view.frame.size.width / 2 - 2;
    CGFloat w = 4;
    CGFloat h = self.view.frame.size.height;
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(x, 0, w, h)];
    centerLine.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:centerLine];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TheCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%zd",indexPath.item];
    return cell;
}


@end
