//
//  DetailInstructionView.h
//  ImitateAlert
//
//  Created by tunsuy on 15/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInstructionView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UIView *shadow;

@property (nonatomic, strong) NSArray *infoArr;

- (void)showInsideView:(UIView *)view;

@end
