
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.
//

#import "MSSCalendarCollectionReusableView.h"
#import "MSSCalendarDefine.h"

@interface MSSCalendarCollectionReusableView ()

@end
@implementation MSSCalendarCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createReusableView];
    }
    return self;
}

- (void)createReusableView
{
    
    CGFloat width = MSS_SCREEN_WIDTH-20;
    CGFloat height = self.frame.size.height;
    CGFloat weekH = height;
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, width, height );
    [self addSubview:headerView];
    
    
    //星期
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, height - weekH, MSS_SCREEN_WIDTH, weekH)];
    
    weekView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:weekView];
    
    NSArray *weekArray = @[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
    int i = 0;
    NSInteger weekLW = width/7.0;
    for(i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * weekLW, 0, weekLW, MSS_WeekViewHeight)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        if(i == 0 || i == 6)
        {
            weekLabel.textColor = MSS_WeekEndTextColor;
        }
        else
        {
            weekLabel.textColor = [UIColor blackColor];
        }
        [weekView addSubview:weekLabel];
    }
    
}



@end
