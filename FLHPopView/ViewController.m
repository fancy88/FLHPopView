//
//  ViewController.m
//  FLHPopView
//
//  Created by apple on 17/2/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PopView.h"

@interface ViewController ()<selectIndexPathDelegate>

@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) NSArray  *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:235/255.0 blue:232/ 255.0 alpha:1.0];
    
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBtn.frame = CGRectMake(40, 200, self.view.frame.size.width - 80, 30);
    [self.clickBtn setTitle:@"点击一下" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.clickBtn setBackgroundColor:[UIColor colorWithRed:212/255.0 green:246/255.0 blue:242/255.0 alpha:1.0]];
    [self.clickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickBtn];
    
    self.dataArr = [NSArray arrayWithObjects:@"日计划",@"周计划",@"月计划",@"季计划",@"年计划", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)clickBtnAction: (UIButton *)button{
    
    CGPoint point = CGPointMake(button.center.x, button.frame.origin.y + 30);
    PopView *view = [[PopView alloc] initWithOrigin:point Width:button.frame.size.width * 0.5 Height:44 * 5 Color:[UIColor whiteColor]];
    view.dataArray = self.dataArr;
    view.delegate  = self;
    [view popView];
    
}

#pragma mark - selectIndexPathDelegate
- (void)selectIndexPathRow: (NSInteger)index{
   [self.clickBtn setTitle:self.dataArr[index] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
