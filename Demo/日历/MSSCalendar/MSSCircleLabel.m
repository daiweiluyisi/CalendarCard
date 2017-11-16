
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.
//

#import "MSSCircleLabel.h"
#import "MSSCalendarDefine.h"

@implementation MSSCircleLabel

- (void)drawRect:(CGRect)rect
{
    if(_isSelected)
    {
        [MSS_SelectBackgroundColor setFill];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.frame.size.height / 2 startAngle:0.0 endAngle:180.0 clockwise:YES];
        [path fill];
    }
    if (_isSelected) self.textColor = [UIColor whiteColor];
    
    [super drawRect:rect];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    [self setNeedsDisplay];
}

@end
