//
//  DMCalendarView.m
//  DMCalendar
//
//  Created by SDC201 on 2017/5/2.
//  Copyright © 2017年 PCEBG. All rights reserved.
//

#import "DMCalendarView.h"

@implementation DMCalendarView
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
    
    UILabel *headlabel;
    
    UIButton *rightButton;
    UIImageView *rightImg;
    
    NSDate *lpDate;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}
#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:date];
}
- (void)createCalendarViewWith:(NSDate *)date{
    
    lpDate=self.date;
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.height / 7;
    
    // 1.year month
    headlabel = [[UILabel alloc] init];
    headlabel.text     = [NSString stringWithFormat:@"%li-%li",[DMCalendarDate year:date],[DMCalendarDate month:date]];
    headlabel.font     = [UIFont systemFontOfSize:14];
    headlabel.frame           = CGRectMake( self.frame.size.width/2-35, 0, 70, itemH);
    headlabel.textAlignment   = NSTextAlignmentCenter;
    [self addSubview:headlabel];
    
    //last month
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftButton.frame=CGRectMake(headlabel.frame.origin.x-50, 0, 40, itemH);
    [leftButton addTarget:self action:@selector(clickMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    
    UIImageView *leftImg=[[UIImageView alloc] initWithFrame:CGRectMake(leftButton.frame.size.width-10, (leftButton.frame.size.height-15)/2, 10, 15)];
    leftImg.image=[UIImage imageNamed:@"leftarr.png"];
    [leftButton addSubview:leftImg];
    
    //next month   if greater than the current month does not show
    rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame=CGRectMake(CGRectGetMaxX(headlabel.frame)+50-itemH, leftButton.frame.origin.y, leftButton.frame.size.width, leftButton.frame.size.height);
    [rightButton addTarget:self action:@selector(clickMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    rightImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, (rightButton.frame.size.height-15)/2, 10, 15)];
    rightImg.image=[UIImage imageNamed:@"rightarr"];
    [rightButton addSubview:rightImg];
    
    // 2.weekday
    NSArray *array = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    UIView *weekBg = [[UIView alloc] init];
    weekBg.frame = CGRectMake(0, CGRectGetMaxY(headlabel.frame), self.frame.size.width, itemH-10);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        week.textColor       = [UIColor blackColor];
        [weekBg addSubview:week];
    }
    
    NSInteger daysInLastMonth = [DMCalendarDate totaldaysInMonth:[DMCalendarDate lastMonth:date]];
    NSInteger daysInThisMonth = [DMCalendarDate totaldaysInMonth:date];
    NSInteger firstWeekday    = [DMCalendarDate firstWeekdayInThisMonth:date];
    NSLog(@"%ld",firstWeekday);
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        
        dayButton.frame = CGRectMake(x, y, itemW, itemH);
        
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5;
        
        //        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger day = 0;
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        NSInteger todayIndex = [DMCalendarDate day:[NSDate date]] + firstWeekday - 1;
        
        if([self judgementMonth] && i ==  todayIndex)
        {
            [self setStyle_Today:dayButton];
            _dayButton = dayButton;
        }else
        {
            dayButton.backgroundColor=[UIColor whiteColor];
            [self setSign:i andBtn:dayButton];
        }
    }
}

#pragma mark 设置已经签到
- (void)setSign:(int)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int now = i-4+1;
        int now2 = [obj intValue];
        if (now2== now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}

//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor greenColor]];
}

#pragma mark - date button style
//设置不是本月的日期字体颜色   ---浅灰色  看的到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(BOOL) judgementMonth
{
    //获取当前月份
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"MM";
    NSInteger dateMon=[[formatter stringFromDate:[NSDate date]] integerValue];
    
    //获取选择的月份
    NSInteger mon=[[headlabel.text substringFromIndex:5] integerValue];
    
    if (mon==dateMon)
    {
        return YES;
    }else
        return NO;
}
- (void)setStyle_Today:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:94/255.0 green:169/255.0 blue:251/255.0 alpha:1]];
}

-(void) clickMonth:(UIButton *)btn
{
    if (btn==rightButton)
    {
        lpDate=[DMCalendarDate nextMonth:lpDate];
        if (self.block) {
            self.block(self);
        }
    }else
    {
        lpDate=[DMCalendarDate lastMonth:lpDate];
        if (self.block) {
            self.block(self);
        }
    }
    
    NSDate *date=lpDate;
    
    headlabel.text = [NSString stringWithFormat:@"%li-%li",[DMCalendarDate year:date],[DMCalendarDate month:date]];
    
    NSInteger daysInLastMonth = [DMCalendarDate totaldaysInMonth:[DMCalendarDate lastMonth:date]];
    NSInteger daysInThisMonth = [DMCalendarDate totaldaysInMonth:date];
    NSInteger firstWeekday    = [DMCalendarDate firstWeekdayInThisMonth:date];
    NSLog(@"%ld",firstWeekday);
    NSInteger todayIndex = [DMCalendarDate day:[NSDate date]] + firstWeekday - 1;
    
    for (int i = 0; i < 42; i++) {
        
        UIButton *dayButton = _daysArray[i];
        
        NSInteger day = 0;
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        if([self judgementMonth] && i ==  todayIndex)
        {
            [self setStyle_Today:dayButton];
            _dayButton = dayButton;
        }else
        {
            dayButton.backgroundColor=[UIColor whiteColor];
            [self setSign:i andBtn:dayButton];
        }
    }
    
}

//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    self.block = block;
}

@end
