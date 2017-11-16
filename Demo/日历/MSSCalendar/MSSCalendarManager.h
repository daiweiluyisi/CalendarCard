//
//  MSSCalendarManager.h
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MSSCalendarViewController.h"
#import "ViewController.h"
@interface MSSCalendarManager : NSObject

// 获取数据源
- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth type:(MSSCalendarViewControllerType)type;

@property (nonatomic,strong)NSIndexPath *startIndexPath;

@end
