//
//  DMCalendarView.h
//  DMCalendar
//
//  Created by SDC201 on 2017/5/2.
//  Copyright © 2017年 PCEBG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCalendarDate.h"

typedef void(^ButtonBlock)(id sender);

@interface DMCalendarView : UIView

@property (nonatomic, strong) NSDate *date;

//今天
@property (nonatomic,strong)  UIButton *dayButton;

@property(nonatomic,strong) NSMutableArray *signArray;

@property (nonatomic, strong, nullable) ButtonBlock block;

- (void)addButtonAction:(ButtonBlock)block;

@end
