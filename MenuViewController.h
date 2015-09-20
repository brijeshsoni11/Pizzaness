//
//  MenuViewController.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
   // NSMutableArray *mutMenuArr;
    NSInteger row;
    NSString *myStr;
    NSString *addStr;
    NSArray *tpArr;
    NSString *tempStr;
    NSMutableArray *mutArry;
    NSIndexPath *selectdIndex;
    NSArray *newArry;
    NSMutableArray *dataArray;
    UIView *viewPopup;
    Boolean isShown;
}
@property(strong,nonatomic)NSMutableArray *menuArr;

@property(strong,nonatomic)NSMutableArray *tableArr;

@property (nonatomic,assign) NSInteger selectedRow_number;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollnView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@property(nonatomic, strong) NSMutableArray *cartArray;

@end
