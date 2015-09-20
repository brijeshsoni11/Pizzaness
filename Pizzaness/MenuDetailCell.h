//
//  MenuDetailCell.h
//  Pizzaness
//
//  Created by wserve on 8/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuDetailCell;
@protocol Toppings <NSObject>

-(void)selectToppingsButtonsIntexTapped:(NSIndexPath *)indexPath ofCustomCell:(MenuDetailCell *)cell;
-(void)selectNoneButtonAtIndexTapped:(NSIndexPath *)indexPath ofCustomCell:(MenuDetailCell *)cell;

@end


@interface MenuDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UIButton *noneBtnActn;
@property (weak, nonatomic) IBOutlet UIButton *rightHalfButtn;
@property (weak, nonatomic) IBOutlet UIButton *fullButton;
@property (weak, nonatomic) IBOutlet UIButton *leftHalfButtn;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<Toppings>delegate;

//Methods
-(IBAction)noneButtonTapped:(UIButton *)senderBtn;
-(IBAction)rightHalfButtonTapped:(UIButton *)senderBtn;
-(IBAction)fullButtonTapped:(UIButton *)senderBtn;
-(IBAction)leftHalfButtonTapped:(UIButton *)senderBtn;
-(IBAction)otherButtonTapped:(UIButton *)senderBtn;

@end
