//
//  LoginViewController.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIAlertViewDelegate>

{
    NSString *tempStr;
    UIAlertView *alertView1;
    UIAlertView *alertView2;
    UIAlertView *alertView3;
    UIView *viewPopup;
    Boolean isShown;
}
- (IBAction)signUpBtn:(id)sender;
- (IBAction)forgetPass:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViews;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwdTxt;
- (IBAction)loginButtonActn:(id)sender;

@end
