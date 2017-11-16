
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.
//

#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarDefine.h"

@implementation MSSCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
//    _imageView.image = [UIImage imageNamed:@"bg"];
    [self.contentView addSubview:_imageView];
    
    _dateLabel = [[MSSCircleLabel alloc]initWithFrame:CGRectMake(0, MSS_Iphone6Scale(5), self.contentView.frame.size.width, 27)];//self.frame.size.height / 2 - MSS_Iphone6Scale(10))
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont systemFontOfSize:MSS_Iphone6Scale(11.0)];
    [self.contentView addSubview:_dateLabel];
    
    _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateLabel.frame), self.contentView.frame.size.width, self.frame.size.height / 2 - MSS_Iphone6Scale(5))];
    _subLabel.textAlignment = NSTextAlignmentCenter;
    _subLabel.font = [UIFont systemFontOfSize:MSS_Iphone6Scale(9.0)];
    [self.contentView addSubview:_subLabel];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _dateLabel.isSelected = isSelected;
}

@end
