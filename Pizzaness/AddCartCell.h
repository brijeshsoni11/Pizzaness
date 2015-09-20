//
//  AddCartCell.h
//  Pizzaness
//
//  Created by wserve on 6/9/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *proTitle;
@property (weak, nonatomic) IBOutlet UITextField *proTxtfd;
@property (weak, nonatomic) IBOutlet UILabel *proPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *proTtlLbl;
@property (weak, nonatomic) IBOutlet UILabel *proFaretotlLbl;
@property (weak, nonatomic) IBOutlet UILabel *proTaxLbl;

@end
