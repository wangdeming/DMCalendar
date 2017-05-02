//
//  DMCalendarDate.h
//  DMCalendar
//
//  Created by SDC201 on 2017/5/2.
//  Copyright © 2017年 PCEBG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCalendarDate : NSObject

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;


@end
