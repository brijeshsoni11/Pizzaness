//
//  AboutViewController.m
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "AboutViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"

@interface AboutViewController ()
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;
@end

@implementation AboutViewController

- (void)viewDidLoad
{
    self.title =@"About";

    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    self.edgesForExtendedLayout = UIRectEdgeNone;  
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
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

    
    NSURL *url=[[NSURL alloc]initWithString:@"http://pizzaness.com/api/about.php"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
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
     NSError *error=nil;
     self.dictResult =[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:&error];
     NSString *about = [self.dictResult objectForKey:@"Description"];
     self.textViewab.text =about;
     self.textViewab.textAlignment = NSTextAlignmentJustified;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
