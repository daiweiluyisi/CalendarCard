
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.
//

#import "MSSCalendarManager.h"
#import "MSSCalendarHeaderModel.h"

@interface MSSCalendarManager ()

@property (nonatomic,strong)NSDate *todayDate;
@property (nonatomic,strong)NSDateComponents *todayCompontents;
@property (nonatomic,strong)NSCalendar *greCalendar;
@property (nonatomic,strong)NSDateFormatter *dateFormatter;
@property (nonatomic,assign)NSInteger startDate;

@end

@implementation MSSCalendarManager

- (instancetype)init
{
    self = [super init];
    {
        _greCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _todayDate = [NSDate date];
        _todayCompontents = [self dateToComponents:_todayDate];
        _dateFormatter = [[NSDateFormatter alloc]init];
    }
    return self;
}

- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth type:(MSSCalendarViewControllerType)type
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    NSDateComponents *components = [self dateToComponents:_todayDate];
    components.day = 1;
    if(type == MSSCalendarViewControllerNextType)
    {
        components.month -= 1;
    }
    else if(type == MSSCalendarViewControllerLastType)
    {
        components.month -= limitMonth;
    }
    else
    {
        components.month -= (limitMonth + 1) / 2;
    }
    NSInteger i = 0;
    for(i = 0;i < limitMonth;i++)
    {
        components.month++;
        MSSCalendarHeaderModel *headerItem = [[MSSCalendarHeaderModel alloc]init];
        NSDate *date = [self componentsToDate:components];
        [_dateFormatter setDateFormat: @"yyyy-MM"];
        NSString *dateString = [_dateFormatter stringFromDate:date];
        headerItem.headerText = dateString;
        headerItem.calendarItemArray = [self getCalendarItemArrayWithDate:date section:i];
        [resultArray addObject:headerItem];
    }
    return resultArray;
}

// 得到每一天的数据源
- (NSArray *)getCalendarItemArrayWithDate:(NSDate *)date section:(NSInteger)section
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSInteger tatalDay = [self numberOfDaysInCurrentMonth:date];
    NSInteger firstDay = [self startDayOfWeek:date];
    
    NSDateComponents *components = [self dateToComponents:date];
    
    // 判断日历有多少列
    NSInteger tempDay = tatalDay + (firstDay - 1);
    NSInteger column = 0;
    if(tempDay % 7 == 0)
    {
        column = tempDay / 7;
    }
    else
    {
        column = tempDay / 7 + 1;
    }
    
    NSInteger i = 0;
    NSInteger j = 0;
    components.day = 0;
    for(i = 0;i < column;i++)
    {
        for(j = 0;j < 7;j++)
        {
            if(i == 0 && j < firstDay - 1)
            {
                MSSCalendarModel *calendarItem = [[MSSCalendarModel alloc]init];
                calendarItem.year = 0;
                calendarItem.month = 0;
                calendarItem.day = 0;
                calendarItem.chineseCalendar = @"";
                calendarItem.holiday = @"";
                calendarItem.week = -1;
                calendarItem.dateInterval = -1;
                [resultArray addObject:calendarItem];
                continue;
            }
            components.day += 1;
            if(components.day == tatalDay + 1)
            {
                i = column;// 结束外层循环
                break;
            }
            MSSCalendarModel *calendarItem = [[MSSCalendarModel alloc]init];
            calendarItem.year = components.year;
            calendarItem.month = components.month;
            calendarItem.day = components.day;
            calendarItem.week = j;
            NSDate *date = [self componentsToDate:components];
            // 时间戳
            calendarItem.dateInterval = [self dateToInterval:date];
            if(_startDate == calendarItem.dateInterval)
            {
                _startIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            }
            [self setChineseCalendarAndHolidayWithDate:components date:date calendarItem:calendarItem];
            
            [resultArray addObject:calendarItem];
        }
    }
    return resultArray;
}

// 一个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth:(NSDate *)date
{
    return [_greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

// 确定这个月的第一天是星期几
- (NSUInteger)startDayOfWeek:(NSDate *)date
{
    NSDate *startDate = nil;
    BOOL result = [_greCalendar rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:date];
    if(result)
    {
        #warning  this happen crash
        return [_greCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:startDate];
    }

    return 0;
}

// 日期转时间戳
- (NSInteger)dateToInterval:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}

#pragma mark 农历和节假日
- (void)setChineseCalendarAndHolidayWithDate:(NSDateComponents *)components date:(NSDate *)date calendarItem:(MSSCalendarModel *)calendarItem
{
    if (components.year == _todayCompontents.year && components.month == _todayCompontents.month && components.day == _todayCompontents.day)
    {
        calendarItem.type = MSSCalendarTodayType;
        calendarItem.holiday = @"今天";
    }
    else
    {
        if([date compare:_todayDate] == 1)
        {
            calendarItem.type = MSSCalendarNextType;
        }
        else
        {
            calendarItem.type = MSSCalendarLastType;
        }
    }

}

#pragma mark NSDate和NSCompontents转换
- (NSDateComponents *)dateToComponents:(NSDate *)date
{
    NSDateComponents *components = [_greCalendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    return components;
}

- (NSDate *)componentsToDate:(NSDateComponents *)components
{
    // 不区分时分秒
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *date = [_greCalendar dateFromComponents:components];
    return date;
}

@end
