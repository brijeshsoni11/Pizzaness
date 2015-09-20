//
//  MenuDetailCell.m
//  Pizzaness
//
//  Created by wserve on 8/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "MenuDetailCell.h"

@implementation MenuDetailCell


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)noneButtonTapped:(UIButton *)senderBtn
{
    [self.leftHalfButtn setSelected:NO];
    [self.leftHalfButtn setImage:[UIImage imageNamed:@"circle4.png"] forState:UIControlStateNormal];
    
    [self.fullButton setSelected:NO];
    [self.fullButton setImage:[UIImage imageNamed:@"circle3.png"] forState:UIControlStateNormal];
    
    [self.rightHalfButtn setSelected:NO];
    [self.rightHalfButtn setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    
    [self.otherButton setSelected:NO];
    [self.otherButton setImage:[UIImage imageNamed:@"circle5.png"] forState:UIControlStateNormal];
    
    [self.delegate selectNoneButtonAtIndexTapped:self.indexPath ofCustomCell:self];
}
-(IBAction)rightHalfButtonTapped:(UIButton *)senderBtn
{
    [self.leftHalfButtn setSelected:NO];
    [self.leftHalfButtn setImage:[UIImage imageNamed:@"circle4.png"] forState:UIControlStateNormal];
    
    [self.fullButton setSelected:NO];
    [self.fullButton setImage:[UIImage imageNamed:@"circle3.png"] forState:UIControlStateNormal];
    
    [self.rightHalfButtn setSelected:YES];
    [self.rightHalfButtn setImage:[UIImage imageNamed:@"green2.png"] forState:UIControlStateSelected];
    
    [self.delegate selectToppingsButtonsIntexTapped:self.indexPath ofCustomCell:self];
}
-(IBAction)fullButtonTapped:(UIButton *)senderBtn
{
    [self.leftHalfButtn setSelected:NO];
    [self.leftHalfButtn setImage:[UIImage imageNamed:@"circle4.png"] forState:UIControlStateNormal];
    
    [self.fullButton setSelected:YES];
    [self.fullButton setImage:[UIImage imageNamed:@"green3.png"] forState:UIControlStateSelected];
    
    [self.rightHalfButtn setSelected:NO];
    [self.rightHalfButtn setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    
    [self.delegate selectToppingsButtonsIntexTapped:self.indexPath ofCustomCell:self];
}
-(IBAction)leftHalfButtonTapped:(UIButton *)senderBtn
{
    [self.leftHalfButtn setSelected:YES];
    [self.leftHalfButtn setImage:[UIImage imageNamed:@"green4.png"] forState:UIControlStateSelected];
    
    [self.fullButton setSelected:NO];
    [self.fullButton setImage:[UIImage imageNamed:@"circle3.png"] forState:UIControlStateNormal];
    
    [self.rightHalfButtn setSelected:NO];
    [self.rightHalfButtn setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    
    [self.delegate selectToppingsButtonsIntexTapped:self.indexPath ofCustomCell:self];
}
-(IBAction)otherButtonTapped:(UIButton *)senderBtn
{
    if ([self.leftHalfButtn isSelected] || [self.fullButton isSelected] || [self.rightHalfButtn isSelected])
    {
        [self.otherButton setSelected:YES];
        [self.otherButton setImage:[UIImage imageNamed:@"green5.png"] forState:UIControlStateSelected];
    }
    
     [self.delegate selectToppingsButtonsIntexTapped:self.indexPath ofCustomCell:self];
}

@end
