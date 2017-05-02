   # DMCalendar
    使用方法：

    //导入头文件
    #import "DMCalendarView.h"

    //初始化
    DMCalendarView *calendarView = [[DMCalendarView alloc]initWithFrame:CGRectMake(15, 74, [UIScreen mainScreen].bounds.size.width-20, 300)];
    
    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    [_signArray addObject:[NSNumber numberWithInt:1]];
    [_signArray addObject:[NSNumber numberWithInt:5]];
    [_signArray addObject:[NSNumber numberWithInt:9]];
    calendarView.signArray = _signArray;

    //设置当前calendarView的date
    calendarView.date=[NSDate date];

    //设置回调方法
    [calendarView addButtonAction:^(id sender) {



    }];

    在当前view上添加canlendarView
    [self.view addSubview:calendarView];

    //图片展示

    ![示例图片](https://github.com/wangdeming/DMCalendar/blob/master/DMCalendar.tiff)
