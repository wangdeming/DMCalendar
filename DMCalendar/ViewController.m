//
//  ViewController.m
//  DMCalendar
//
//  Created by SDC201 on 2017/5/2.
//  Copyright © 2017年 PCEBG. All rights reserved.
//

#import "ViewController.h"
#import "DMCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DMCalendarView *calendarView = [[DMCalendarView alloc]initWithFrame:CGRectMake(15, 74, [UIScreen mainScreen].bounds.size.width-20, 300)];
    
    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    [_signArray addObject:[NSNumber numberWithInt:1]];
    [_signArray addObject:[NSNumber numberWithInt:5]];
    [_signArray addObject:[NSNumber numberWithInt:9]];
    calendarView.signArray = _signArray;
    
    calendarView.date=[NSDate date];
    
    [calendarView addButtonAction:^(id sender) {
        
        
        
    }];
    
    [self.view addSubview:calendarView];
    
}


@end
