//
//  ContactViewController.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactViewController : UIViewController<MFMailComposeViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIView *viewPopup;
    Boolean isShown;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollCont;
@property (weak, nonatomic) IBOutlet UITextView *textViewa;
@property (weak, nonatomic) IBOutlet UIWebView *webViewa;
@property (weak, nonatomic) IBOutlet UILabel *labelDet;
@property (weak, nonatomic) IBOutlet UILabel *labelTit;
@property (weak, nonatomic) IBOutlet UIWebView *webViewb;

- (IBAction)clearBtnPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *frstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emalName;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxtFd;
- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *adressTxtVw;
@property (weak, nonatomic) IBOutlet UITextView *comntTxtVw;


@end
