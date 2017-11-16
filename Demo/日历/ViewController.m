
//  日历
//
//  Created by Paul on 2017/11/6.
//  Copyright © Paul. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
#import "CardItem.h"
#import "CardViewConstants.h"


#import "MSSCalendarManager.h"

@interface ViewController ()<CardViewDelegate, CardViewDataSource>
{
    BOOL __oneTypeItem;
    CardViewItemScrollMode __cardViewMode;
}

@property (weak, nonatomic) IBOutlet CardView *cardView;





@property (nonatomic,strong)NSMutableArray *dataArray;/** 日期数据*/
@property (nonatomic,strong)NSMutableArray *mileageArray;/** 里程数据*/
@property (nonatomic,assign) NSInteger  firstDayIndex;/**< 每月第一天是在第几个cell*/
@property (nonatomic, assign) NSArray  *tiltelArr;/**< 描述*/


@end

@implementation ViewController



static NSString * ITEM_XIB    = @"CardItem";
static NSString * ITEM_RUID   = @"Item_RUID";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    self.cardView.delegate   = self;
    self.cardView.dataSource = self;
    self.cardView.maxItems   = 3;
    self.cardView.scaleRatio = 0.05;
    
    // 修改约束后 cardView 的高度不会立即生效，依然是以 530 来计算，会导致 item 项布局错误，所以此处调用
    [self.view layoutIfNeeded];
    
    [self.cardView registerXibFile:ITEM_XIB forItemReuseIdentifier:ITEM_RUID];
    
    [self.cardView reloadData];
    
    
   
    _dataArray = [[NSMutableArray alloc]init];
    _mileageArray = [[NSMutableArray alloc] init];
    _firstDayIndex = 0;
    
    
    self.limitMonth = 3;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    self.type = MSSCalendarViewControllerLastType;
    self.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    self.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
    [self initDataSource];
}

- (void)initDataSource
{
    __oneTypeItem  = YES;
    __cardViewMode = CardViewItemScrollModeRemove;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MSSCalendarManager *manager = [[MSSCalendarManager alloc] init];
        
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:self.limitMonth type:self.type];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.dataArray addObjectsFromArray:tempDataArray];
            self.dataArray = (NSMutableArray *)[[self.dataArray reverseObjectEnumerator] allObjects];
            NSLog(@"日历数组个数：%lu",_dataArray.count);
            [self.cardView reloadData];
        });
    });
}
















#pragma mark - CYKJCardViewDelegate/DataSource

- (NSInteger)numberOfItemsInCardView:(CardView *)cardView
{
    return self.dataArray.count;
}

- (CardViewItem *)cardView:(CardView *)cardView itemAtIndex:(NSInteger)index
{
    
    CardItem * item = (CardItem *)[cardView dequeueReusableCellWithIdentifier:ITEM_RUID];
    item.afterTodayCanTouch  = self.afterTodayCanTouch;
    item.beforeTodayCanTouch = self.beforeTodayCanTouch;
    item.headerItem          = self.dataArray[index];
    
    return item;
}

- (CGRect)cardView:(CardView *)cardView rectForItemAtIndex:(NSInteger)index
{
    return CGRectMake(0, 0, SCREEN_WIDTH-20, SCREEN_WIDTH*481/355);
}

- (void)cardView:(CardView *)cardView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"卡片%ld被选中", (long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)calendarAction:(id)sender {

}


@end
