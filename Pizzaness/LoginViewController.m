//
//  LoginViewController.m
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "SingaltonClass.h"
#import "MenuViewController.h"

@interface LoginViewController ()
{
    SingaltonClass *sharedSingleton;
    
}
@end
@implementation LoginViewController

- (void)viewDidLoad
{
    self.title =@"Login";
     alertView1.delegate=self;
     alertView2.delegate=self;
     alertView3.delegate=self;
    self.scrollViews.contentSize=CGSizeMake(320,600);
 
      self.edgesForExtendedLayout = UIRectEdgeNone;
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [button addTarget:revealController action:@selector(revealToggle:)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:barButton ,nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
//    NSURL *url=[[NSURL alloc]initWithString:@"http://www.gcalaprecision.com/api/contact.php"];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
//    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
//    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
//    
//    [connection start];

    [super viewDidLoad];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpBtn:(id)sender
{
    SignUpViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
    [self.navigationController pushViewController:newView animated:YES];
    
}

- (IBAction)forgetPass:(id)sender {
}

- (IBAction)loginButtonActn:(id)sender

{
    NSURL *url = [NSURL URLWithString:@"http://pizzaness.com/api/login.php"];
    
    
    NSDictionary *dictParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userNameTxt.text,@"EmailId",self.passwdTxt.text,@"Password",nil];
    
    NSLog(@"diiiii %@",dictParameters);
    
    NSError *error = nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictParameters options:NSJSONWritingPrettyPrinted error:&error];
    
    // Create request body
    NSMutableData *body = [NSMutableData data];
    // Append of the body with your data
    [body appendData:jsonData];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPBody:body];
    // Set request method POST
    [request setHTTPMethod:@"POST"];
    // Set request Headers
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         sharedSingleton = [SingaltonClass sharedInstance];
         
         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         NSError        *error = nil;
         NSLog(@"response............. %@",responseString);
         NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
         NSLog(@"order... %@",dic);
         NSString *strVal =[dic objectForKey:@"response"];
         
         NSDictionary *dicData =[dic objectForKey:@"Data"];
         NSString *strEmail =[dicData objectForKey:@"Email Id"];
         
          [[NSUserDefaults standardUserDefaults]setObject:strEmail forKey:@"Email"];
         [[NSUserDefaults standardUserDefaults]setObject:strVal forKey:@"KEY_NAME"];
         
         if ([strVal isEqualToString:@"Success"])
         {
            alertView1 = [[UIAlertView alloc] initWithTitle:@"User Login"
                                                             message:@"Success"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alertView1 show];
             
             alertView1.tag = 1;
         }
         
         else if ([strVal isEqualToString:@"Login Fail"])
         {
             alertView2 = [[UIAlertView alloc] initWithTitle:@"Login Fail"
                                                             message:@"Please Sign Up"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alertView2 show];
             alertView2.tag=2;
         }
         
         else if ([strVal isEqualToString:@"Fail! UserName And Password Must Be Filled"])
         {
            alertView3 = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                             message:@"Fail! UserName And Password Must Be Filled"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alertView3 show];
             alertView3.tag=3;
         }
         
       [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"KEY_NAME"];
         
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         // Failure
                                         
                                         NSLog(@"Error %@", error);
                                         
                                     }];
    
        [operation start];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView1.tag==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MenuViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"menu"];
        [self.navigationController pushViewController:mainview animated:YES];
        
    }
    else if (alertView2.tag==2)
    {
    
    
    }else if (alertView3.tag==3)
    {
        
        
    }
}

@end
