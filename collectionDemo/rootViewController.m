//
//  rootViewController.m
//  collectionDemo
//
//  Created by Jack on 14-7-7.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "rootViewController.h"
#import "CollectionViewController.h"
@interface rootViewController ()

@end

@implementation rootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(150, 150, 60, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"单击" forState:UIControlStateNormal];
    [button setTitle:@"单击" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(showCollection) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)showCollection
{
    CollectionViewController *collectVC = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
