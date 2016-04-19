//
//  DetailInstructionView.m
//  ImitateAlert
//
//  Created by tunsuy on 15/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "DetailInstructionView.h"

#define kTableViewTop 64
#define kTableViewLeft 15
#define kCloseBtnWidth 30
#define kTipViewWidth 30

@implementation DetailInstructionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutAllViews];
    }
    return self;
}

- (void)layoutAllViews{
    self.backgroundColor = [UIColor clearColor];
//    self.alpha = 0.7;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kTableViewLeft, kTableViewTop, [UIScreen mainScreen].bounds.size.width-kTableViewLeft*2, [UIScreen mainScreen].bounds.size.height-kTableViewTop*2) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    _closeBtn.frame = CGRectMake(kTableViewLeft-10, kTableViewTop-10, kCloseBtnWidth, kCloseBtnWidth);
    [_closeBtn addTarget:self action:@selector(closeDetailInstruction:) forControlEvents:UIControlEventTouchUpInside];
    
    _shadow = [[UIView alloc] initWithFrame:self.frame];
    _shadow.backgroundColor = [UIColor whiteColor];
    _shadow.alpha = 0.7;
    
    _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTipViewWidth, kTipViewWidth)];
    _tipView.center = CGPointMake((_tableView.frame.size.width-kTipViewWidth)/2, _tableView.frame.size.height/2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, _tipView.frame.size.height)];
    [path addLineToPoint:CGPointMake(_tipView.frame.size.width/2, 0)];
    [path addLineToPoint:CGPointMake(_tipView.frame.size.width, _tipView.frame.size.height)];
    CAShapeLayer *tiplayer = [CAShapeLayer layer];
    tiplayer.path = path.CGPath;
    tiplayer.strokeColor = [UIColor blueColor].CGColor;
    tiplayer.fillColor = [UIColor clearColor].CGColor;
    [_tipView.layer addSublayer:tiplayer];
    
//    [_tableView addSubview:_tipView];
    [self addSubview:_shadow];
    [self addSubview:_tableView];
    [self addSubview:_closeBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeDetailInstruction:)];
    [self addGestureRecognizer:tap];
}

- (void)showInsideView:(UIView *)view{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    popAnimation.duration = 0.7;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7f, 0.7f, 0.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f,@1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
    
    [view addSubview:self];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    positionAnimation.duration = 0.5;
//    positionAnimation.speed = 1;
//    positionAnimation.repeatCount = INT32_MAX;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:_tipView.center];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_tipView.center.x, _tipView.center.y-5)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.duration = 0.5;
//    opacityAnimation.speed = 1;
//    opacityAnimation.repeatCount = MAXFLOAT;
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.byValue = @(1.0);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[popAnimation,opacityAnimation];
    animationGroup.speed = 1.0;
    animationGroup.duration = 1.0;
    animationGroup.repeatCount = MAXFLOAT;
//    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_tipView.layer addAnimation:animationGroup forKey:nil];
    
    [_tableView addSubview:_tipView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = _infoArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return cell;
}

- (void)closeDetailInstruction:(id)sender{
    [_tableView removeFromSuperview];
    [_closeBtn removeFromSuperview];
    [_shadow removeFromSuperview];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(_tableView.frame, point)) {
        return NO;
    }
    return YES;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//}

@end
