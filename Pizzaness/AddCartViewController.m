//
//  AddCartViewController.m
//  Pizzaness
//
//  Created by wserve on 6/9/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "AddCartViewController.h"
#import "AddCartCell.h"
#import "SingaltonClass.h"
#import "ShipingViewController.h"

@interface AddCartViewController ()
{
    SingaltonClass *sharedSingleton;
    
}

@end

@implementation AddCartViewController
@synthesize Str;


- (void)viewDidLoad
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    sharedSingleton = [SingaltonClass sharedInstance];

    NSLog(@"cartarrayinmenu=%@",sharedSingleton.allDataArray);
//    sharedSingleton = [SingaltonClass sharedInstance];
//    Str = [sharedSingleton.numValue lastObject];
//    strNum =[NSString stringWithFormat:@"%@",Str];
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationItem.hidesBackButton=YES;
//    self.addObjectArr =[[NSMutableArray alloc]init];
//        NSLog(@"value are %@",_cartArray);
//    
//    if ([_cartArray isKindOfClass:[NSArray class]])
//    {
//        ticketsArray = [[NSMutableArray alloc] initWithArray:_cartArray];
//    }
//    else if([_cartArray isKindOfClass:[NSDictionary class]])
//    {
//        ticketsArray = [[NSMutableArray alloc] initWithObjects:_cartArray, nil];
//    }
  //  [self.addObjectArr addObject:ticketsArray];
  //  [sharedSingleton.singletonArray addObject:ticketsArray];
    
    [self.cartTableView reloadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView

{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section

{
    //return [sharedSingleton.singletonArray count];
    return [sharedSingleton.allDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"CartCell";
    AddCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell == nil)
    {
        cell = [[AddCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    NSDictionary *dicData = [sharedSingleton.allDataArray objectAtIndex:indexPath.row];
    {
        cell.proTaxLbl.text =@"5.67%";
        float zval = [cell.proTxtfd.text floatValue] * [[dicData objectForKey:@"Price"] floatValue];
        float taxablePrice = [cell.proTaxLbl.text floatValue] / 100;
        float totalpri = zval * taxablePrice;
        float taxableprices = zval + totalpri;
        
        NSString *zText = [NSString stringWithFormat:@"%.2f", zval];
        NSString *taxText = [NSString stringWithFormat:@"%.2f", taxableprices];
        
        cell.proTtlLbl.text =zText;
        cell.proTitle.text =[dicData objectForKey:@"Title"];
        cell.proPriceLbl.text =[dicData objectForKey:@"Price"];
        cell.proFaretotlLbl.text =taxText;
        cell.backgroundColor =[UIColor clearColor];
        cell.selectedBackgroundView.backgroundColor =[UIColor yellowColor];
        
        [cell.proTxtfd setTag:indexPath.row];
        [cell.proTxtfd setText: [dicData objectForKey:@"quantity"] ];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   AddCartCell *cell = (AddCartCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.selected)
    {
      cell.backgroundColor =[UIColor clearColor];
    }
   
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,140)];
    
    
    UILabel *lblTAX=[[UILabel alloc]init];
    [lblTAX setFrame:CGRectMake(3, 0, 100,20)];
    [lblTAX setText:@"TAX %"];
    [lblTAX setTextColor:[UIColor whiteColor]];
    [lblTAX setBackgroundColor:[UIColor clearColor]];
    [lblTAX setFont:[UIFont systemFontOfSize:14]];
    
    UILabel *lblGRAND=[[UILabel alloc]init];
    [lblGRAND setFrame:CGRectMake(3, 30, 120,20)];
    [lblGRAND setText:@"GRAND TOAL"];
    [lblGRAND setBackgroundColor:[UIColor clearColor]];
    [lblGRAND setTextColor:[UIColor whiteColor]];
    [lblGRAND setFont:[UIFont systemFontOfSize:14]];

    
    UILabel *totalTax=[[UILabel alloc]init];
    [totalTax setFrame:CGRectMake(210, 0, 100,20)];
    [totalTax setTextColor:[UIColor whiteColor]];
    [totalTax setBackgroundColor:[UIColor whiteColor]];
    [totalTax setFont:[UIFont systemFontOfSize:14]];

   
    UILabel *totalPrice=[[UILabel alloc]init];
    [totalPrice setFrame:CGRectMake(210, 30, 100,20)];
    [totalPrice setTextColor:[UIColor whiteColor]];
    [totalPrice setBackgroundColor:[UIColor whiteColor]];
    [totalPrice setFont:[UIFont systemFontOfSize:14]];

  

    UIButton *orderMore=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [orderMore setTitle:@"OrderMore" forState:UIControlStateNormal];
    [orderMore addTarget:self action:@selector(orderMore:) forControlEvents:UIControlEventTouchUpInside];
    orderMore.frame=CGRectMake(35,80, 100,25);
    [orderMore setBackgroundColor:[UIColor blackColor]];
    orderMore.titleLabel.font = [UIFont systemFontOfSize:17.0];
    
    UIButton *continueMore=[UIButton buttonWithType:UIButtonTypeCustom];
    [continueMore setTitle:@"Continue" forState:UIControlStateNormal];
    [continueMore addTarget:self action:@selector(continueMore:) forControlEvents:UIControlEventTouchUpInside];
    [continueMore setBackgroundColor:[UIColor blackColor]];
    continueMore.frame=CGRectMake(190,80, 100,25);
    continueMore.titleLabel.font = [UIFont systemFontOfSize:17.0];
    
    
    [footerView addSubview:lblTAX];
    [footerView addSubview:lblGRAND];
    [footerView addSubview:totalTax];
    [footerView addSubview:totalPrice];
    
    [footerView addSubview:orderMore];
    [footerView addSubview:continueMore];
    
    return footerView;
    
}
-(void)orderMore:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MenuViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"menu"];
    [self.navigationController pushViewController:mainview animated:YES];

}
-(void)continueMore:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ShipingViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"Shiping"];
    [self.navigationController pushViewController:mainview animated:YES];
    
}


-(void)textDidChangeForTextFieldInCell:(UITextField *)textField
{
   
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSLog(@"Tag Value =%ld",(long)textField.tag);
    
    NSLog(@"array =%@",self.menuViewController.cartArray);
    
    NSMutableDictionary *selectedItemDict = [[NSMutableDictionary alloc]initWithDictionary:[self.menuViewController.cartArray objectAtIndex:textField.tag]];
    [selectedItemDict setObject:textField.text forKey:@"quantity"];
    [self.menuViewController.cartArray replaceObjectAtIndex:textField.tag withObject:selectedItemDict];
    NSLog(@"array =%@",self.menuViewController.cartArray);

    
    
         [self.cartTableView reloadData];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(UITextField *)sender
{
    
}

@end
