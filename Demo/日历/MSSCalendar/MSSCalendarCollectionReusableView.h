//
//  MSSCalendarCollectionReusableView.h
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSCalendarCollectionReusableView : UICollectionReusableView

/**
 日期显示的Lable 如 05月2017
 */
@property (nonatomic, strong) UILabel *headerLabel;/**< 日期显示的Lable*/
@property (nonatomic, strong) UILabel *headerMileageLabel;/**< 显示一个月总里程*/
@property (nonatomic, strong) UILabel *headerUseTimeLabel;/**< 显示一个月总用时*/
@end
