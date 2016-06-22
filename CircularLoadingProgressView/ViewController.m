//
//  ViewController.m
//  CircularLoadingProgressView
//
//  Created by 小蔡 on 16/6/22.
//  Copyright © 2016年 小蔡. All rights reserved.
//

#import "ViewController.h"
#import "XCLoadingProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) UISlider * slider;
@property (nonatomic, strong) UIImageView * backView;
@property (nonatomic, strong) XCLoadingProgressView * progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, 200, 20)];
    [_slider addTarget:self action:@selector(sliderAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 230, 200, 180)];
    _backView.image = [UIImage imageNamed:@"dog"];
    [self.view addSubview:_backView];
    
    _progressView = [[XCLoadingProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _progressView.center = CGPointMake(_backView.bounds.size.width/2, _backView.bounds.size.height/2);
    [_backView addSubview:self.progressView];
}

- (void)sliderAction
{
    if (self.slider.value == 0) {
        [self.progressView removeFromSuperview];
        _progressView = [[XCLoadingProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _progressView.center = CGPointMake(_backView.bounds.size.width/2, _backView.bounds.size.height/2);
        [_backView addSubview:self.progressView];
    }
    self.progressView.progress = self.slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
