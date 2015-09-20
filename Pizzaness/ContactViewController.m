//
//  ContactViewController.m
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "ContactViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"

@interface ContactViewController ()
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;
@end

@implementation ContactViewController

- (void)viewDidLoad
{
    self.title =@"Contact Us";

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

    NSURL *url=[[NSURL alloc]initWithString:@"http://pizzaness.com/api/contactus.php"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    [connection start];

     self.scrollCont.contentSize=CGSizeMake(320,2500);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buttonAction2:(id)sender
{
    
    UIView *viewPopup =[[UIView alloc]initWithFrame:CGRectMake(160,0,160,70)];
    UILabel *nameLbl =[[UILabel alloc]initWithFrame:CGRectMake(10,3,140,30)];
    UIButton *logButtn =[[UIButton alloc]initWithFrame:CGRectMake(42,35,60,30)];
    [logButtn addTarget:self action:@selector(logoutButton:)forControlEvents:UIControlEventTouchUpInside];
    
    viewPopup.backgroundColor=[UIColor whiteColor];
    logButtn.backgroundColor =[UIColor redColor];
    nameLbl.backgroundColor =[UIColor lightGrayColor];
    [viewPopup addSubview:nameLbl];
    [viewPopup addSubview:logButtn];
    
    [self.view addSubview:viewPopup];
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
    NSArray *abc =[self.dictResult objectForKey:@"item"];
    NSString *strValue =[[abc objectAtIndex:1]valueForKey:@"Description"];
    NSString *strTitle =[[abc objectAtIndex:1]valueForKey:@"Title"];
    self.labelDet.text =strTitle;
    NSString *descriptionString=[NSString stringWithFormat:@"%@",strValue];
    
    NSString *close =[NSString stringWithFormat:@"</body></html>"];
    [self.webViewa loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:justify; font-size:16px;font-family:HelveticaNeue-simple;color:#0000;'>%@%@",descriptionString,close] baseURL:nil];
    [self.webViewa setBackgroundColor:[UIColor clearColor]];
    [self.webViewb setBackgroundColor:[UIColor clearColor]];
    NSString *strdis =[[abc objectAtIndex:0]valueForKey:@"Description"];
    NSString *strTit =[[abc objectAtIndex:0]valueForKey:@"Title"];
    self.labelTit.text =strTit;
    NSString *desString=[NSString stringWithFormat:@"%@",strdis];
    NSString *closes =[NSString stringWithFormat:@"</body></html>"];
    [self.webViewb loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:justify; font-size:16px;font-family:HelveticaNeue-simple;color:#0000;'>%@%@",desString,closes] baseURL:nil];
    
}

- (IBAction)submitBtn:(id)sender
{
    if(self.frstName == nil || [self.frstName.text isEqualToString:@""])
    {
        [self showErrorAlert1];
    }
    else if(self.lastName == nil || [self.lastName.text isEqualToString:@""])
    {
        [self showErrorAlert2];
    }
    
    else  if(self.phoneTxtFd == nil || [self.phoneTxtFd.text isEqualToString:@""])
    {
        [self showErrorAlert3];
    }
    else if(self.emalName == nil || [self.phoneTxtFd.text isEqualToString:@""])
    {
        [self showErrorAlert4];
    }
    else if(self.adressTxtVw == nil || [self.adressTxtVw.text isEqualToString:@""])
    {
        [self showErrorAlert5];
    }
    else if(self.comntTxtVw == nil || [self.comntTxtVw.text isEqualToString:@""])
    {
        [self showErrorAlert6];
    }
    else
    {
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:[NSString stringWithFormat:@"Mr/Mrs. %@",self.frstName.text]];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"brijeshmca111@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody =[NSString stringWithFormat:@"firstName=%@\nlastName=%@\nEmail=%@\nPhone No=%@\naddress=%@\nComments=%@",self.frstName.text,self.lastName.text,self.phoneTxtFd.text,self.emalName.text,self.adressTxtVw.text,self.comntTxtVw.text];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        
        [self presentViewController:mailer animated:YES completion:NULL];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollCont  setContentOffset:CGPointMake(0,568)];
    return [textField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    if (textField.tag == 0)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,820)];
    }
    else if (textField.tag == 1)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,870)];
    }
    else if (textField.tag == 2)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,890)];
    }
    
    else if (textField.tag == 3)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,920)];
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 4)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,1120)];
    }
    else if (textView.tag == 5)
    {
        [self.scrollCont setContentOffset:CGPointMake(0,1190)];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scrollCont  setContentOffset:CGPointMake(0,568)];
    
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.tag == 4)
    {
        // return NO;
        return [self.adressTxtVw resignFirstResponder];
    }
    else if (textView.tag == 5)
    {
        //return NO;
        return [self.comntTxtVw resignFirstResponder];
    }
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
    
}

-(void) textFieldDidEndEditing:(UITextField*) textField
{
    [self.scrollCont  setContentOffset:CGPointMake(0,568)];
}

- (IBAction)clearBtn:(id)sender
{
    
}

-(void) showErrorAlert1
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your First Name" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}
-(void) showErrorAlert2
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your Last Name" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}
-(void) showErrorAlert3
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your Phone No" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}


-(void) showErrorAlert4
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your Email" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}
-(void) showErrorAlert5
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your Address" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}
-(void) showErrorAlert6
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Enter your Comments" delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            
            break;
        case MFMailComposeResultFailed:
            
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearBtnPress:(id)sender
{
    self.frstName.text=@"";
    self.lastName.text=@"";
    self.phoneTxtFd.text=@"";
    self.emalName.text=@"";
    self.adressTxtVw.text=@"";
    self.comntTxtVw.text=@"";
}


@end
