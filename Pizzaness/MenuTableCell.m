//
//  MenuTableCell.m
//  Pizzaness
//
//  Created by wserve on 6/3/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "MenuTableCell.h"

@implementation MenuTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addBtnPressd:(id)sender {
}
@end
