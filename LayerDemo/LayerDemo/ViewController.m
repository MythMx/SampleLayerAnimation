//
//  ViewController.m
//  LayerDemo
//
//  Created by liu on 15/12/30.
//  Copyright © 2015年 vizz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) CALayer *topLayer;
@property (weak, nonatomic) CALayer *bottomLayer;
@property (weak, nonatomic) CAGradientLayer *gradientLayer;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTopLayer];
    
    [self setupBottomLayer];
    
    [self setupGradineLayer];
}


- (void)setupTopLayer
{
    CAShapeLayer *topLayer = [[CAShapeLayer alloc] init];
    topLayer.strokeColor = [UIColor whiteColor].CGColor;
    topLayer.fillColor = [UIColor clearColor].CGColor;
    topLayer.lineWidth = 6.0f;
    topLayer.strokeEnd = 0.4;
    topLayer.strokeStart = 0;
    topLayer.lineCap = kCALineCapRound;
    topLayer.position = CGPointMake(_topView.bounds.size.width * 0.5, _topView.bounds.size.height * 0.5);
    topLayer.frame = _topView.bounds;
    topLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _topView.bounds.size.width, _topView.bounds.size.height)].CGPath;
    [_topView.layer addSublayer:topLayer];
    self.topLayer = topLayer;

}

- (void)setupBottomLayer
{
    CAShapeLayer *bottomLayer = [[CAShapeLayer alloc] init];
    bottomLayer.strokeColor = [UIColor whiteColor].CGColor;
    bottomLayer.fillColor = [UIColor clearColor].CGColor;
    bottomLayer.lineWidth = 6.0f;
    bottomLayer.lineCap = kCALineCapRound;
    bottomLayer.position = CGPointMake(_bottomView.bounds.size.width * 0.5, _bottomView.bounds.size.height * 0.5);
    bottomLayer.frame = _bottomView.bounds;
    bottomLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _bottomView.bounds.size.width, _bottomView.bounds.size.height)].CGPath;
    [_bottomView.layer addSublayer:bottomLayer];
    self.bottomLayer = bottomLayer;

}


- (void)setupGradineLayer
{
    UILabel *text = [[UILabel alloc] init];
    text.font = [UIFont systemFontOfSize:15.0f];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = @"iOS开发者，github:https://github.com/MythMx";
    text.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    [text sizeToFit];
    [self.view addSubview:text];
    
    CAGradientLayer *maskLayer = [[CAGradientLayer alloc] init];
    maskLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    maskLayer.bounds = text.frame;
    maskLayer.colors = @[(id)[self arc4randomColor].CGColor,
                         (id)[self arc4randomColor].CGColor,
                         (id)[self arc4randomColor].CGColor,
                         (id)[self arc4randomColor].CGColor];
//    maskLayer.locations = @[@(0.3), @(0.3), @(0.2), @(0.2)];
    maskLayer.startPoint = CGPointMake(0, 0);
    maskLayer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:maskLayer];
    self.gradientLayer = maskLayer;
    
    maskLayer.mask = text.layer;
    text.frame = maskLayer.bounds;
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeColor)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)changeColor
{
    _gradientLayer.colors = @[(id)[self arc4randomColor].CGColor,
                              (id)[self arc4randomColor].CGColor,
                              (id)[self arc4randomColor].CGColor,
                              (id)[self arc4randomColor].CGColor,
                              (id)[self arc4randomColor].CGColor];

}

- (UIColor *)arc4randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(226) / 225.0
                           green:arc4random_uniform(226) / 225.0
                            blue:arc4random_uniform(226) / 225.0 alpha:1];
}

- (void)beginTopLayerAnimation
{
    CABasicAnimation *baseAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    baseAnim.duration = 1.5;
    baseAnim.repeatCount = HUGE;
    baseAnim.fromValue = 0;
    baseAnim.toValue = @(2 * M_PI);
    [self.topLayer addAnimation:baseAnim forKey:nil];
}

- (void)beginBottomLayerAnimation
{
    CABasicAnimation *start = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    start.fromValue = @(-0.5);
    start.toValue = @(1);
    
    
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    end.fromValue = @(0);
    end.toValue = @(1);
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.5f;
    group.repeatCount = HUGE;
    group.animations = @[start, end];
    [self.bottomLayer addAnimation:group forKey:nil];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self beginTopLayerAnimation];
    
    [self beginBottomLayerAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
