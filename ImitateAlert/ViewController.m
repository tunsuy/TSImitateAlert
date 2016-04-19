//
//  ViewController.m
//  ImitateAlert
//
//  Created by tunsuy on 15/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "DetailInstructionView.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *infoArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"奖励详情" style:UIBarButtonItemStylePlain target:self action:@selector(displayDetail)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"IMG2.jpg"];
    [self.view addSubview:_imageView];
    
    [self initData];
    
}

- (BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void)initData{
    _infoArr = @[@"发生的故事大概是个德国法国", @"是个帅哥帅哥豆腐干豆腐", @"大哥大法官大地飞歌", @"山东健康哥哥"];
}

- (void)displayDetail{
    DetailInstructionView *detailView = [[DetailInstructionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    detailView.infoArr = _infoArr;
    [detailView showInsideView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
