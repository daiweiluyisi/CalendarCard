//
//  CardItem.h
//  Card
//
//  Created by D on 17/1/4.
//  Copyright © 2017年 D. All rights reserved.


#import "CardViewItem.h"
#import "MSSCalendarHeaderModel.h"

@class CardData;
@interface CardItem : CardViewItem

@property (strong, nonatomic) MSSCalendarHeaderModel *headerItem;

@property (nonatomic,assign) BOOL afterTodayCanTouch;// 今天之后的日期是否可以点击
@property (nonatomic,assign) BOOL beforeTodayCanTouch;// 今天之前的日期是否可以点击

- (void)setItemWithData:(CardData *)data;

@end
