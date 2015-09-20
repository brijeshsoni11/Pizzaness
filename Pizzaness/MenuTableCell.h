//
//  MenuTableCell.h
//  Pizzaness
//
//  Created by wserve on 6/3/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgMenu;
@property (weak, nonatomic) IBOutlet UITextView *discrptnLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
- (IBAction)addBtnPressd:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;

@end
