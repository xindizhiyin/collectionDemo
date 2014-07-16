//
//  CollectionViewController.m
//  collectionDemo
//
//  Created by Jack on 14-7-7.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

NSString *const MJCollectionViewCellIdentifier = @"Cell";

#import "CollectionViewController.h"
#import "UIScrollView+MJRefresh.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

 
- (id)init
{
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageArr = @[@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg",@"21.jpg",@"22.jpg",@"23.jpg",@"24.jpg",@"25.jpg",@"26.jpg",@"27.jpg",@"28.jpg",@"29.jpg",@"30.jpg",@"31.jpg",@"32.jpg",@"33.jpg",@"34.jpg"];
	self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    self.view.userInteractionEnabled = YES;
    self.containArr = [[NSMutableArray alloc] init];
    tempHeader =6;
    for (int i =6; i<12; i++) {
        [self.containArr addObject:[imageArr objectAtIndex:i]];
    }
    [self addHeader];
    [self addFooter];
   
}


- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    if (tempHeader==0) {
        return;
    }
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加6条假数据
        for (int i = 0; i<6; i++) {
            [vc.containArr insertObject:[imageArr objectAtIndex:tempHeader] atIndex:0];
            tempHeader--;
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView headerEndRefreshing];
        });
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addFooter
{
    
    __unsafe_unretained typeof(self) vc = self;
    
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加6条假数据
        for (int i = 0; i<6; i++) {
            if (vc.containArr.count==imageArr.count) {
                return;
            }
            [vc.containArr addObject:[imageArr objectAtIndex:tempFooter]];
            tempFooter++;
        }
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView footerEndRefreshing];
        });
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    tempFooter = (int)self.containArr.count;
    return self.containArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:[self.containArr objectAtIndex:indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.image = image;
    imageView.tag = indexPath.row +100;
    
    imageView.userInteractionEnabled = YES;
    collectionView.userInteractionEnabled = YES;

    

    [cell addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:indexPath.row+100];
    UIButton *secondTap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    secondTap.frame = CGRectMake(0, 80, 320, 320);
    [secondTap setBackgroundImage:imageView.image forState:UIControlStateNormal];
    [secondTap addTarget:self action:@selector(scaleToFormer:) forControlEvents:UIControlEventTouchUpInside];
    UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 480)];
    panView.backgroundColor = [UIColor blackColor];
    panView.tag =110120;
    [panView addSubview:secondTap];
    [self.view addSubview:panView];

}

- (void)scaleToFormer:(UIButton *)button
{
    UIView *view = [self.view viewWithTag:110120];
    [view removeFromSuperview];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
