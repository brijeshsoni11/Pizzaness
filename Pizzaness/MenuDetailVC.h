//
//  MenuDetailVC.h
//  Pizzaness
//
//  Created by wserve on 8/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuDetailCell.h"
#import "SingaltonClass.h"
#import <CoreData/CoreData.h>

@interface MenuDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UITextFieldDelegate,Toppings>

{
    NSMutableArray *titleArray;
    
    UIToolbar *profileToolBar;
    UIPickerView *productProfilePickerView;
    CGFloat animatedDistance;
    NSDictionary *dictionary;
    Boolean isShown;
    UIButton * btn;
    NSArray *arrData;
    NSString *smallStr;
    NSString *mediumStr;
    NSString *largeStr;
    NSString *xtraLarge;
    NSString *checkVal;
    NSArray *pizzaTypeArr;

    SingaltonClass *sharedSingleton;
        


    
}
- (IBAction)addToCartBtn:(id)sender;
@property(strong,nonatomic) NSString *intVAL;
@property (weak, nonatomic) IBOutlet UILabel *priceLblTxt;
@property (weak, nonatomic) IBOutlet UITextField *quatityTxt;

@property (weak, nonatomic) IBOutlet UIImageView *menuImge;
@property(nonatomic, retain)NSDictionary* dicArry;
@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;
@property (weak, nonatomic) IBOutlet UITextField *pizzaTypeField;
@property (weak, nonatomic) IBOutlet UITextView *textViews;
@property (weak, nonatomic) IBOutlet UITextField *riceptName;
@property (weak, nonatomic) IBOutlet UILabel *discriptnLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UITableView *menuTblView;
//@property(nonatomic, retain)NSArray* data;
@property(nonatomic, retain)NSArray* sections;
@property(nonatomic, retain)NSMutableArray* sectionAnimals;

@property(nonatomic, retain)NSMutableArray* itemArray;


@end
