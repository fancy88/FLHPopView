//
//  PopView.m
//  FLHPopView
//
//  Created by apple on 17/2/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Length 5

@interface PopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation PopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithOrigin: (CGPoint)origin Width: (NSInteger)width Height: (NSInteger)height Color: (UIColor *)color{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.origin = origin;
        self.width  = width;
        self.height = height;
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        self.backgroundView.backgroundColor = color;
        [self addSubview:self.backgroundView];
        //添加tableView
        [self.backgroundView addSubview:self.tableView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGFloat startX = self.origin.x;
     CGFloat startY = self.origin.y;
     CGContextMoveToPoint(context, startX, startY);
     CGContextAddLineToPoint(context, startX + Length, startY + Length);
     CGContextAddLineToPoint(context, startX - Length, startY + Length);
    
     CGContextClosePath(context);
     [self.backgroundView.backgroundColor setFill];
     [self.backgroundColor setStroke];
     CGContextDrawPath(context, kCGPathFillStroke);
    
}

#pragma mark - popView
- (void)popView{
    // 同步显示 子控件(views)和(self)
    NSArray *results = [self.backgroundView subviews];
    for (UIView *view in results) {
        [view setHidden:YES];
    }
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    
    self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
    CGFloat origin_x    = self.origin.x - self.width / 2;
    CGFloat origin_y    = self.origin.y + Length;
    CGFloat size_width  = self.width;
    CGFloat size_height = self.height;
    [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
}

- (void)startAnimateView_x:(CGFloat) x
                        _y:(CGFloat) y
              origin_width:(CGFloat) width
             origin_height:(CGFloat) height
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.frame = CGRectMake(x, y, width, height);
    }completion:^(BOOL finished) {
        NSArray *results = [self.backgroundView subviews];
        for (UIView *view in results) {
            [view setHidden:NO];
        }
    }];
}

- (void)dismiss
{
    /**
     *  删除 在backgroundView 上的子控件
     */
    NSArray *results = [self.backgroundView subviews];
    
    for (UIView *view in results) {
        
        [view removeFromSuperview];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![[touches anyObject].view isEqual:self.backgroundView]) {
        [self dismiss];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width - 5, self.backgroundView.frame.size.height)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexPathRow:)]) {
        [self dismiss];
        [self.delegate selectIndexPathRow:indexPath.row];
    }
}


@end
