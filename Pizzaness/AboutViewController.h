//
//  AboutViewController.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
{
    UIView *viewPopup;
    Boolean isShown;

}
@property (weak, nonatomic) IBOutlet UITextView *textViewab;

@end
