//
//  ShipingViewController.h
//  Pizzaness
//
//  Created by wserve on 6/16/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <InAppSDK/FDPaymentAuthorizationViewControllerDelegate.h>

@interface ShipingViewController : UIViewController<FDPaymentAuthorizationViewControllerDelegate>

@property (strong, nonatomic) UIAlertView* alert;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPaymentType;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

- (IBAction)proceedBtnPress:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *shipMbTextFd;
@property (weak, nonatomic) IBOutlet UITextField *shipCountryTxt;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextFd;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
@property (weak, nonatomic) IBOutlet UITextField *addrsTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *TownCityTxtFd;
@property (weak, nonatomic) IBOutlet UITextField *emailAddrsTxt;
@property (weak, nonatomic) IBOutlet UITextField *shipLastTxt;
@property (weak, nonatomic) IBOutlet UITextField *shipFirstTxtFd;
@property (weak, nonatomic) IBOutlet UIScrollView *shipScrollView;
- (IBAction)checkBoxBtnActn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userMbTextFd;
@property (weak, nonatomic) IBOutlet UITextField *userCountryTxt;
@property (weak, nonatomic) IBOutlet UITextField *userpostCodeTextFd;
@property (weak, nonatomic) IBOutlet UITextField *useraddrsTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *userTownCityTxtFd;
@property (weak, nonatomic) IBOutlet UITextField *useremailAddrsTxt;
@property (weak, nonatomic) IBOutlet UITextField *userLastTxt;

@property (weak, nonatomic) IBOutlet UITextField *userFirstTxtFd;
@end
