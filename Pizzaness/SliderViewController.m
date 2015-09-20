//
//  SliderViewController.m
//  D B Malorey
//
//  Created by wserve on 4/29/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "SliderViewController.h"
#import "SWRevealViewController.h"
#import "AboutViewController.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "ContactViewController.h"
#import "ViewController.h"
#import "SliderCell.h"

@interface SliderViewController ()
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;
@end

@implementation SliderViewController

- (void)viewDidLoad
{
    
     check =@"abc";
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 10.0, 50.0, 50.0)];
    [button setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0]];
    [button addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
     nsArray =[[NSArray alloc]init];
    
     nsArray =[[NSArray alloc]initWithObjects:@"Home",@"About",@"Menu",@"Login",@"Contact Us" ,nil];
     imgArry =   [NSMutableArray arrayWithObjects:
                 [UIImage imageNamed:@"Home32.png"],
                 [UIImage imageNamed:@"About32.png"],
                 [UIImage imageNamed:@"Pizza Filled-32(1).png"],
                 [UIImage imageNamed:@"Lock32.png"],
                 [UIImage imageNamed:@"Contacts32.png"],nil];

    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.tableViewSl reloadData];
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([check isEqualToString:@"abc"])
    {
        return [nsArray count];
    }
    else
    {
        return [imgArry count];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Slider";
    
    SliderCell *cell = (SliderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SliderCell" owner:self options:nil];
        cell = (SliderCell *)[nib objectAtIndex:0];
    }
    cell.backgroundColor =[UIColor clearColor];
    cell.titleView.text =[nsArray objectAtIndex:indexPath.row];
    cell.imgView.image =[imgArry objectAtIndex:indexPath.row];
    cell.textLabel.font =[UIFont boldSystemFontOfSize:16];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strVal = [nsArray objectAtIndex:indexPath.row];
    
    if ([strVal isEqualToString:@"Home"])
    {
        
        SWRevealViewController *revealController = [self revealViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"home"];
        
        
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainview];
        [revealController pushFrontViewController:navigationController1 animated:YES];
        
        
    }
    else if ([strVal isEqualToString:@"About"])
    {
        SWRevealViewController *revealController = [self revealViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        AboutViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"about"];
        
        
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainview];
        [revealController pushFrontViewController:navigationController1 animated:YES];
    }
    else if ([strVal isEqualToString:@"Menu"])
    {
        SWRevealViewController *revealController = [self revealViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        MenuViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"menu"];
        
        
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainview];
        [revealController pushFrontViewController:navigationController1 animated:YES];
    }
    else if ([strVal isEqualToString:@"Login"])
    {
        
        SWRevealViewController *revealController = [self revealViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        LoginViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        
        
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainview];
        [revealController pushFrontViewController:navigationController1 animated:YES];
    }
    
    else if ([strVal isEqualToString:@"Contact Us"])
    {
        SWRevealViewController *revealController = [self revealViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ContactViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"contact"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:mainview];
        [revealController pushFrontViewController:navigationController1 animated:YES];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
