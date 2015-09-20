//
//  SignUpViewController.h
//  Pizzaness
//
//  Created by wserve on 5/28/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

{

    NSInteger textTag;
    NSArray *countryArr;
    NSArray *nameArr;
    UIPickerView *picker;
    CGFloat animatedDistance;

}

//@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViw;
@property (weak, nonatomic) IBOutlet UITextField *titleTxt;
@property (weak, nonatomic) IBOutlet UITextField *fstName;
@property (weak, nonatomic) IBOutlet UITextField *lstName;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *passTxt;
@property (weak, nonatomic) IBOutlet UITextField *conPasTxt;
@property (weak, nonatomic) IBOutlet UITextField *telpTxt;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxt;
@property (weak, nonatomic) IBOutlet UITextField *addressTxt;
@property (weak, nonatomic) IBOutlet UITextField *cityTxt;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *countryTxt;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
- (IBAction)submitBtnActn:(id)sender;
- (IBAction)clearBtnActn:(id)sender;

@end
