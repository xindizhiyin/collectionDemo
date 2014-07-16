//
//  CollectionViewController.h
//  collectionDemo
//
//  Created by Jack on 14-7-7.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
{
    NSArray *imageArr;
   int tempHeader;
    int tempFooter;
//    UIImageView *imageView;
}
@property (nonatomic,retain) NSMutableArray *containArr;
- (void)addHeader;
- (void)addFooter;
@end
