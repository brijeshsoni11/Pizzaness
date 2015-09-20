//
//  AddCartViewController.h
//  Pizzaness
//
//  Created by wserve on 6/9/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
@interface AddCartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{

    NSMutableArray *ticketsArray;
    NSString *temStr;
    NSNumber *num;
    NSString *strNum;
    NSIndexPath *txtIndexPath;
    NSInteger newVal;
}

@property(strong,nonatomic)MenuViewController *menuViewController;
@property(strong,nonatomic)id cartArray;
@property(nonatomic,strong) NSMutableArray *selectedItems;
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
- (IBAction)orderMorePrss:(id)sender;
- (IBAction)continueBtnPres:(id)sender;
@property(strong,nonatomic)NSMutableArray *addObjectArr;
@property(strong,nonatomic)NSString *addStr;
@property(strong,nonatomic)NSString *Str;


@end
