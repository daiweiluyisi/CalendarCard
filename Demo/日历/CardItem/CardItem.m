
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.


#import "CardItem.h"
#import "CardViewConstants.h"




#import "MSSCalendarDefine.h"
#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarHeaderModel.h"
#import "MSSCalendarCollectionReusableView.h"


@interface CardItem ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView  * bgView;
@property (weak, nonatomic) IBOutlet UIImageView * iconImageView;
@property (weak, nonatomic) IBOutlet UIView  * alphaMaskView;


@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIView *total_mileage_label;
@property (weak, nonatomic) IBOutlet UILabel *month_mileage_label;
@property (weak, nonatomic) IBOutlet UILabel *month_time_label;
@property (weak, nonatomic) IBOutlet UILabel *month_speed_label;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end


@implementation CardItem

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowRadius  = 2;
    [self addCalendarView];
    
}

- (void)addCalendarView {
    
//    NSInteger width = MSS_Iphone6Scale(54);
//    NSInteger height = MSS_Iphone6Scale(60);
    
    NSInteger width = (MSS_SCREEN_WIDTH-20)/7.5;
    NSInteger height = (_collectionView.frame.size.height-MSS_HeaderViewHeight)/5;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.headerReferenceSize = CGSizeMake(_collectionView.frame.size.width, MSS_HeaderViewHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled   = NO;
    
    
    [_collectionView registerClass:[MSSCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell"];
    
    
    [_collectionView registerClass:[MSSCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MSSCalendarCollectionReusableView"];
    
}

- (void)setHeaderItem:(MSSCalendarHeaderModel *)headerItem {
    _headerItem = headerItem;
    self.monthLabel.text = [NSString stringWithFormat:@"%@",headerItem.headerText];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.headerItem) {
        return self.headerItem.calendarItemArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell" forIndexPath:indexPath];
    
    MSSCalendarModel *calendarItem = self.headerItem.calendarItemArray[indexPath.row];
    
    //** 在这里取出某一个月，在取某一天 section月  row天*/
    cell.dateLabel.text = @"";
    cell.dateLabel.textColor = [UIColor blackColor];
    cell.subLabel.text = @"";
    cell.subLabel.textColor = MSS_SelectSubLabelTextColor;
    cell.isSelected = NO;
    cell.userInteractionEnabled = NO;
    if(calendarItem.day > 0)
    {
        cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
        
//        //以日历号数作为索引在数组中取出相应的值
//        if (indexPath.section < self.mileageArray.count) {
//            这里处理公里数（subLabel）的赋值
//        }
        cell.userInteractionEnabled = YES;
    }
    
    
    if (indexPath.item == 18||indexPath.item == 11) {
        cell.isSelected = YES;
        cell.subLabel.text = @"112KM";
        cell.subLabel.backgroundColor = [UIColor redColor];
    }
    
    
    if(!_afterTodayCanTouch)
    {
        if(calendarItem.type == MSSCalendarNextType)
        {
            cell.dateLabel.textColor = MSS_TouchUnableTextColor;
            cell.subLabel.textColor = MSS_TouchUnableTextColor;
            cell.userInteractionEnabled = NO;
        }
    }
    if(!_beforeTodayCanTouch)
    {
        if(calendarItem.type == MSSCalendarLastType)
        {
            cell.dateLabel.textColor = MSS_TouchUnableTextColor;
            cell.subLabel.textColor = MSS_TouchUnableTextColor;
            cell.userInteractionEnabled = NO;
        }
    }
    
    
    return cell;
}



// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MSSCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MSSCalendarCollectionReusableView" forIndexPath:indexPath];
        
        NSArray *temp = [self.headerItem.headerText componentsSeparatedByString:@"-"];
        NSString *tempStr = [NSString stringWithFormat:@"%@月%@",temp[1],temp[0]];
        NSMutableAttributedString * headerStr = [[NSMutableAttributedString alloc] initWithString:tempStr];
        NSDictionary *headerDic = @{NSFontAttributeName:[UIFont systemFontOfSize:30]};
        [headerStr setAttributes:headerDic range:NSMakeRange(0, 2)];
        
        headerView.headerLabel.attributedText = headerStr;
        headerView.frame = CGRectMake(0, 0, collectionView.frame.size.width, 50);
        
        
        
        return headerView;
    }
    return [[UICollectionReusableView alloc] init];
}
#pragma mark - 点击日历某一天
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    //    MSSCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}


- (void)addAlphaMaskView
{
    self.alphaMaskView.alpha = 0.1;
}

- (void)removeAlphaMaskView
{
    self.alphaMaskView.alpha = 0;
}







@end
