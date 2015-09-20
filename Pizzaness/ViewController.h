//
//  ViewController.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    UIView *viewPopup;
    Boolean isShown;
    
}
@property (weak, nonatomic) IBOutlet UIButton *radius;
- (IBAction)radius:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actvtyIndictr;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewh;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewb;
@property (weak, nonatomic) IBOutlet UILabel *lablName;
@property (weak, nonatomic) IBOutlet UITextView *txtDiscptn;
@property (weak, nonatomic) IBOutlet UIImageView *imgSub1;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscptn;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgSub2;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscptn1;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice1;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle1;

@end
