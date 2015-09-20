//
//  ViewController.m
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"


@interface ViewController ()
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    //self.radius.layer.cornerRadius=7;
      self.title =@"Home";
      self.scrollViewh.contentSize=CGSizeMake(320,800);
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
    
    NSURL *url=[[NSURL alloc]initWithString:@"http://pizzaness.com/api/home.php"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
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
    [self.actvtyIndictr startAnimating];
    [connection start];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)buttonAction2:(id)sender
{
    if (!isShown)
    {
        
        NSString *strVal =[[NSUserDefaults standardUserDefaults] objectForKey:@"Email"];
        
        viewPopup =[[UIView alloc]initWithFrame:CGRectMake(190,0,130,55)];
        UILabel *nameLbl =[[UILabel alloc]initWithFrame:CGRectMake(5,3,130,25)];
        nameLbl.text =strVal;
        [nameLbl setFont:[UIFont systemFontOfSize:14]];
        UIButton *logButtn =[[UIButton alloc]initWithFrame:CGRectMake(33,25,60,22)];
    
        UIImage *btnImage = [UIImage imageNamed:@"logout(n).png"];
        [logButtn setImage:btnImage forState:UIControlStateNormal];
        
        
        [logButtn addTarget:self action:@selector(logoutButton:)forControlEvents:UIControlEventTouchUpInside];
        
        viewPopup.backgroundColor =[UIColor whiteColor];
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
    NSError *error=nil;
    
    self.dictResult =[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:&error];
    
    NSArray *arr = [self.dictResult objectForKey:@"item"];
    NSString *myStr = [[arr objectAtIndex:2]valueForKey:@"Description"];
    
    
    NSString *strNew = [myStr stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
     NSString *strN = [strNew stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    self.txtDiscptn.text =strN;
    NSString *ImageURL =[[arr objectAtIndex:2]valueForKey:@"Image"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.imgViewb.image = [UIImage imageWithData:imageData];
    
    NSString *myStr1 = [[arr objectAtIndex:1]valueForKey:@"Description"];
    self.lblTitle.text  = [[arr objectAtIndex:1]valueForKey:@"Title"];
    self.lblPrice.text  = [[arr objectAtIndex:1]valueForKey:@"Price"];
    NSString *strNew1 = [myStr1 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *strN1 = [strNew1 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    self.lblDiscptn.text =strN1;
    NSString *Image =[[arr objectAtIndex:1]valueForKey:@"Image"];
    NSData *imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:Image]];
    self.imgSub1.image = [UIImage imageWithData:imageData1];
    
    NSString *myStr2 = [[arr objectAtIndex:0]valueForKey:@"Description"];
    self.lblTitle1.text  = [[arr objectAtIndex:0]valueForKey:@"Title"];
    self.lblPrice1.text  = [[arr objectAtIndex:0]valueForKey:@"Price"];
    NSString *strNew2 = [myStr2 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *strN2 = [strNew2 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    self.lblDiscptn1.text =strN2;
    NSString *Image2 =[[arr objectAtIndex:0]valueForKey:@"Image"];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:Image2]];
    self.imgSub2.image = [UIImage imageWithData:imageData2];
    [self.actvtyIndictr stopAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)radius:(id)sender {
}
@end
