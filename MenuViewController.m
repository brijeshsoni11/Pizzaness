//
//  MenuViewController.m
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "MenuCelll.h"
#import "MenuTableCell.h"
#import "DLImageLoader.h"
#import "AddCartViewController.h"
#import "SingaltonClass.h"
#import "MenuDetailVC.h"
#import "ViewController.h"
#import "LoginViewController.h"

@interface MenuViewController ()
{
  SingaltonClass *sharedSingleton;

}
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;

@end

@implementation MenuViewController
@synthesize menuArr,tableArr;

- (void)viewDidLoad
{
    self.title =@"Menu";

    menuArr =[[NSMutableArray alloc]init];
    tableArr =[[NSMutableArray alloc]init];
    self.cartArray =  [[NSMutableArray alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0.0,0.0,32.0,32.0)];
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [button addTarget:revealController action:@selector(revealToggle:)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:barButton ,nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    NSString *strVal =[[NSUserDefaults standardUserDefaults] objectForKey:@"KEY_NAME"];
    if (strVal != NULL)
    {
        UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setImage:[UIImage imageNamed:@"userlog.png"] forState:UIControlStateNormal];
        
        [button2 addTarget:self action:@selector(buttonAction2:)forControlEvents:UIControlEventTouchUpInside];
        [button2 setFrame:CGRectMake(0,0,32,32)];
        UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
        
        NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:barButton2 ,nil];
        self.navigationItem.rightBarButtonItems = myButtonArray1;
        
    }

    NSURL *url=[[NSURL alloc]initWithString:@"http://wserve.org/us/pizzaness/api/menu.php"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
   
    [self.menuTableView reloadData];

    [connection start];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buttonAction2:(id)sender
{
    if (!isShown)
    {
        viewPopup =[[UIView alloc]initWithFrame:CGRectMake(160,0,160,70)];
        UILabel *nameLbl =[[UILabel alloc]initWithFrame:CGRectMake(10,3,140,30)];
        UIButton *logButtn =[[UIButton alloc]initWithFrame:CGRectMake(42,35,60,30)];
        [logButtn addTarget:self action:@selector(logoutButton:)forControlEvents:UIControlEventTouchUpInside];
        
        viewPopup.backgroundColor =[UIColor whiteColor];
        logButtn.backgroundColor  =[UIColor redColor];
        nameLbl.backgroundColor   =[UIColor lightGrayColor];
        [viewPopup addSubview:nameLbl];
        [viewPopup addSubview:logButtn];
        [self.view addSubview:viewPopup];
        
        isShown = true;
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            //cantentView.backgroundColor = [UIColor blackColor];
            viewPopup.hidden=YES;
        }];
        isShown = false;
    }
    
}

-(void)logoutButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KEY_NAME"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:mainview animated:YES];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Try after some time" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data =[[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    myStr =@"abc";
  
    NSError *error=nil;
    self.dictResult =[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:&error];
    
    menuArr =[self.dictResult objectForKey:@"Category"];
    
    if ([myStr isEqualToString:@"abc"])
     {
         
        tpArr =[[menuArr objectAtIndex:0] objectForKey:@"Item"];
         [self.menuTableView reloadData];
         
     }
    
     [self.menuCollnView reloadData];
  

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
     return [menuArr count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     static NSString *identifier = @"wserve";
    
     MenuCelll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
       // edidte by siraj
     cell.backgroundColor =[UIColor whiteColor];
     NSString *menuName =  [[menuArr objectAtIndex:indexPath.row] objectForKey:@"Menu"];
    NSString *str = [menuName uppercaseString];
    cell.menuNameLbl.text =str;

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     myStr = nil;
     tempStr=@"gcd";
     tableArr = [[menuArr objectAtIndex:indexPath.row] objectForKey:@"Item"];
    
     MenuCelll *cell = (MenuCelll *)[collectionView cellForItemAtIndexPath:indexPath];
     cell.backgroundColor =[UIColor yellowColor];

     [self.menuTableView reloadData];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenuCelll *cell = (MenuCelll *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    [self.menuTableView reloadData];

}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView

{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section

{
    if ([myStr isEqualToString:@"abc"])
    {
        return tpArr.count;
    }
    else  if ([tempStr isEqualToString:@"gcd"])
    {
      return tableArr.count;
    }

    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cellidentifier = @"wserve";
    
    MenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[MenuTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    [cell.actIndicator startAnimating];
    
    if ([myStr isEqualToString:@"abc"])

    {
        
        NSString *abc =[[tpArr objectAtIndex:indexPath.row]objectForKey:@"Title"];
        
        [[DLImageLoader sharedInstance] loadImageFromUrl:[[tpArr objectAtIndex:indexPath.row]objectForKey:@"Image"]                                           completed:^(NSError *error, UIImage *image) {
            if (error == nil)
            {
                cell.imgMenu.image=image;
                [cell.actIndicator stopAnimating];
            } else
            {
                // if we got an error when load an image
            }
        }];

        NSString *myStr2 =[[tpArr objectAtIndex:indexPath.row]objectForKey:@"Description"];
        
        NSString *strNew2 = [myStr2 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        NSString *strN2 = [strNew2 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        NSString *strN3 = [strN2 stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
        cell.discrptnLbl.text =strN3;
        cell.priceLbl.text =[[tpArr objectAtIndex:indexPath.row] objectForKey:@"Price"];
        cell.titleLbl.text =abc;
       
    }
    
    else if ([tempStr isEqualToString:@"gcd"])
        
    {
        NSString *abc =[[tableArr objectAtIndex:indexPath.row]objectForKey:@"Title"];
        
        [[DLImageLoader sharedInstance] loadImageFromUrl:[[tableArr objectAtIndex:indexPath.row]objectForKey:@"Image"]                                           completed:^(NSError *error, UIImage *image) {
            if (error == nil)
            {
                cell.imgMenu.image=image;
                [cell.actIndicator stopAnimating];
            } else
            {
                // if we got an error when load an image
            }
        }];
        
        NSString *myStr2 =[[tableArr objectAtIndex:indexPath.row]objectForKey:@"Description"];
        NSString *strNew2 = [myStr2 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        NSString *strN2 = [strNew2 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        NSString *strN3 = [strN2 stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
        cell.discrptnLbl.text =strN3;
        cell.priceLbl.text =[[tableArr objectAtIndex:indexPath.row] objectForKey:@"xlarge_price"];
        cell.titleLbl.text =abc;
        
        }
    
        cell.addToCart.tag = indexPath.row;
    
       [cell.addToCart addTarget:self action:@selector(addToCartButtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedBackgroundView.backgroundColor =[UIColor yellowColor];
    
         return cell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id abc =[[tableArr objectAtIndex:indexPath.row]objectForKey:@"Item"];
//    
//     MenuTableCell *cell = (MenuTableCell*)[tableView cellForRowAtIndexPath:indexPath];
//    
//   
//
//}

-(void)addToCartButtn:(UIButton*)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    
    NSInteger variable = indexPath.row;
    
    NSMutableDictionary *itemDict =[[NSMutableDictionary alloc]initWithDictionary: [tableArr objectAtIndex:variable]];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MenuDetailVC *mainview = [storyboard instantiateViewControllerWithIdentifier:@"MenuVC"];
    [mainview setDicArry:itemDict];
    [self.navigationController pushViewController:mainview animated:YES];
    
  //  NSMutableDictionary *itemDict =[[NSMutableDictionary alloc]initWithDictionary: [tableArr objectAtIndex:sender.tag]];
    
    
//    
//    if ([itemDict objectForKey:@"quantity"] == Nil)
//    {
//         [itemDict setObject:@"1" forKey:@"quantity"];
//    }
//    else
//    {
//        NSString *str = [self.cartArray objectAtIndex:sender.tag ];
//        
//        [itemDict setObject:str forKey:@"quantity"];
//
//    }
//   
//    [self.cartArray addObject:itemDict];
//    NSLog(@"self.cartArray =%@",self.cartArray);
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    AddCartViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"AddCart"];
//    [mainview setCartArray:self.cartArray];
//    [mainview setMenuViewController:self];
//    [self.navigationController pushViewController:mainview animated:YES];
    
}

@end
