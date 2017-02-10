//
//  PopView.h
//  FLHPopView
//
//  Created by apple on 17/2/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectIndexPathDelegate <NSObject>

- (void)selectIndexPathRow: (NSInteger)index;

@end

@interface PopView : UIView

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) id<selectIndexPathDelegate> delegate;

// 初始化方法

- (instancetype)initWithOrigin: (CGPoint)origin Width: (NSInteger)width Height: (NSInteger)height Color: (UIColor *)color;

- (void)popView;

- (void)dismiss;

@end
