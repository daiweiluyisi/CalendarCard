//
//  ViewController.h
//  日历
//
//  Created by 爱车保 on 2017/11/6.
//  Copyright © 2017年 成都爱车保信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSCalendarDefine.h"

@interface ViewController : UIViewController

@property (nonatomic,assign) NSInteger limitMonth;// 显示几个月的数据
@property (nonatomic,assign) MSSCalendarViewControllerType type;
@property (nonatomic,assign) BOOL afterTodayCanTouch;// 今天之后的日期是否可以点击
@property (nonatomic,assign) BOOL beforeTodayCanTouch;// 今天之前的日期是否可以点击
@property (nonatomic, copy)  NSString  *carID;/**< 这是我传的 用于获取 日月里程的参数*/

@end

