//
//  SignUpViewController.m
//  Pizzaness
//
//  Created by wserve on 5/28/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "SignUpViewController.h"
#import "SWRevealViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface SignUpViewController ()

@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION     = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION     = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT    = 158;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT   = 162;

@implementation SignUpViewController
//@synthesize picker;


- (void)viewDidLoad
{
    countryArr = [NSArray arrayWithObjects:@"Afghanistan", @"Akrotiri",@"Albania",@"Algeria",@"American Samoa", @"Andorra",@"Angola",@"Anguilla",@"Antarctica",@"Antigua and Barbuda",@"Argentina",@"Armenia",@"Aruba",@"Ashmore and Cartier Islands",@"Australia",@"Austria", @"Azerbaijan",@"The Bahamas",@"Bahrain",@"Bangladesh", @"Barbados",@"Bassas da India",@"Belarus",@"Belgium", @"Belize",@"Benin",@"Bermuda",@"Bhutan",@"Bolivia", @"Bosnia and Herzegovina",@"Botswana",@"Bouvet Island", @"Brazil",@"British Indian Ocean Territory",@"British Virgin Islands",@"Brunei",@"Bulgaria",@"Burkina Faso", @"Burma",@"Burundi",@"Cambodia",@"Cameroon",@"Canada", @"Cape Verde",@"Cayman Islands",@"Central African Republic",@"Chad",@"Chile",@"China",@"Christmas Island", @"Clipperton Island",@"Cocos (Keeling) Islands", @"Colombia",@"Comoros",@"Democratic Republic of the Congo",@"Republic of the Congo",@"Cook Islands",@"Coral Sea Islands",@"Costa Rica",@"Cote d'Ivoire",@"Croatia", @"Cuba",@"Cyprus",@"Czech Republic",@"Denmark", @"Dhekelia",@"Djibouti",@"Dominica",@"Dominican Republic", @"Ecuador",@"Egypt",@"El Salvador",@"Equatorial Guinea", @"Eritrea",@"Estonia",@"Ethiopia",@"Europa Island", @"Falkland Islands (Islas Malvinas)",@"Faroe Islands", @"Fiji",@"Finland",@"France",@"French Guiana",@"French Polynesia",@"French Southern and Antarctic Lands", @"Gabon",@"The Gambia",@"Gaza Strip",@"Georgia", @"Germany",@"Ghana",@"Gibraltar",@"Glorioso Islands", @"Greece",@"Greenland",@"Grenada",@"Guadeloupe",@"Guam", @"Guatemala",@"Guernsey",@"Guinea",@"Guinea-Bissau", @"Guyana",@"Haiti",@"Heard Island and McDonald Islands", @"Holy See (Vatican City)",@"Honduras",@"Hong Kong", @"Hungary",@"Iceland",@"India",@"Indonesia",@"Iran", @"Iraq",@"Ireland",@"Isle of Man",@"Israel",@"Italy", @"Jamaica", @"Jan Mayen",@"Japan",@"Jersey",@"Jordan", @"Juan de Nova Island",@"Kazakhstan",@"Kenya", @"Kiribati",@"North Korea",@"South Korea",@"Kuwait", @"Kyrgyzstan",@"Laos",@"Latvia",@"Lebanon",@"Lesotho", @"Liberia",@"Libya",@"Liechtenstein",@"Lithuania", @"Luxembourg",@"Macau",@"Macedonia",@"Madagascar", @"Malawi", @"Malaysia", @"Maldives", @"Mali",@"Malta", @"Marshall Islands",@"Martinique",@"Mauritania", @"Mauritius",@"Mayotte",@"Mexico",@"Federated States of Micronesia",@"Moldova",@"Monaco",@"Mongolia", @"Montserrat",@"Morocco",@"Mozambique",@"Namibia", @"Nauru",@"Navassa Island",@"Nepal",@"Netherlands", @"Netherlands Antilles",@"New Caledonia",@"New Zealand", @"Nicaragua",@"Niger",@"Nigeria",@"Niue", @"Norfolk Island",@"Northern Mariana Islands",@"Norway",@"Oman", @"Pakistan",@"Palau",@"Panama",@"Papua New Guinea", @"Paracel Islands",@"Paraguay",@"Peru",@"Philippines", @"Pitcairn Islands",@"Poland",@"Portugal",@"Puerto Rico", @"Qatar",@"Reunion",@"Romania",@"Russia",@"Rwanda", @"Saint Helena",@"Saint Kitts and Nevis",@"Saint Lucia", @"Saint Pierre and Miquelon",@"Saint Vincent and the Grenadines",@"Samoa",@"San Marino",@"Sao Tome and Principe",@"Saudi Arabia",@"Senegal",@"Serbia", @"Montenegro",@"Seychelles",@"Sierra Leone",@"Singapore", @"Slovakia",@"Slovenia",@"Solomon Islands",@"Somalia", @"South Africa",@"South Georgia and the South Sandwich Islands",@"Spain",@"Spratly Islands",@"Sri Lanka", @"Sudan",@"Suriname",@"Svalbard",@"Swaziland",@"Sweden", @"Switzerland",@"Syria",@"Taiwan",@"Tajikistan", @"Tanzania",@"Thailand",@"Tibet",@"Timor-Leste",@"Togo", @"Tokelau",@"Tonga",@"Trinidad and Tobago",@"Tromelin Island",@"Tunisia",@"Turkey",@"Turkmenistan",@"Turks and Caicos Islands",@"Tuvalu",@"Uganda",@"Ukraine",@"United Arab Emirates",@"United Kingdom",@"United States", @"Uruguay",@"Uzbekistan",@"Vanuatu",@"Venezuela", @"Vietnam",@"Virgin Islands",@"Wake Island",@"Wallis and Futuna",@"West Bank",@"Western Sahara",@"Yemen", @"Zambia",@"Zimbabwe", nil];
    
      nameArr =[[NSArray  alloc]initWithObjects:@"Mr.",@"Mrs.",@"Miss.",@"Dr.",nil];
    
      picker.showsSelectionIndicator = YES;
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
      NSURL *url=[[NSURL alloc]initWithString:@"http://www.gcalaprecision.com/api/contact.php"];
      NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
      [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
      NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
      [connection start];

      self.scrollViw.contentSize=CGSizeMake(320,2100);
      [super viewDidLoad];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   if (textField.tag==0)
       
        {
            [self attachPickerToTextField:textField];
            [self.titleTxt resignFirstResponder];
        }
         else if (textField.tag==11)
        {
            [self attachPickerToTextField:textField];
            [self.countryTxt resignFirstResponder];
        }
   
       [self slideViewUpForTextField:textField];
}

-(void) textFieldDidEndEditing:(UITextField*) textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void) slideViewUpForTextField:(UITextField *)textField

{
    
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
        heightFraction = 0.0;
    else if (heightFraction > 1.0)
        heightFraction = 1.0;
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    else
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}


- (void)attachPickerToTextField: (UITextField*) textField
{
    textTag  = textField.tag;
    
    if (textField.tag==0)
    {
        self.titleTxt.delegate=self;
        
    }
    else if (textField.tag==11)
    {
        self.countryTxt.delegate=self;
    }
    
    picker =[[UIPickerView alloc]initWithFrame:CGRectMake(20,290, 280,360)];
    [picker setDataSource: self];
    [picker setDelegate: self];
    picker.showsSelectionIndicator = YES;
    picker.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:picker];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (textTag==0)
    {
        return [nameArr count];
        
    }
    else if (textTag==11)
    {
        return [countryArr count];
    }
    return YES;
    
}

# pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (textTag==0)
    {
        return [nameArr objectAtIndex:row];
        
    }
    else  if (textTag==11)
    {
        return [countryArr objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (textTag==0)
        
    {
        self.titleTxt.text =[nameArr objectAtIndex:row];
        picker.hidden=YES;
        
    }
    
    else if (textTag==11)
    {
        
        self.countryTxt.text = [countryArr objectAtIndex:row];
        picker.hidden=YES;

     
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
}

- (IBAction)submitBtnActn:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://pizzaness.com/api/signup.php"];
    NSDictionary *dictParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.titleTxt.text,@"Title",self.fstName.text,@"First Name",self.lstName.text,@"Last Name",self.emailTxt.text,@"Email",self.passTxt.text,@"Password",self.telpTxt.text,@"Telephone",self.mobileTxt.text,@"Mobile",self.addressTxt.text,@"Address",self.cityTxt.text,@"City",self.zipCodeTxt.text,@"Zipcode",self.countryTxt.text,@"Country",nil];
    
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
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSError        *error = nil;
        NSLog(@"response............. %@",responseString);
        
        NSMutableDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"order... %@",dic);
        
        }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // Failure
        
        NSLog(@"Error %@", error);
        
    }];
    
    [operation start];
 }

- (IBAction)clearBtnActn:(id)sender
{
    self.titleTxt.text   = @"";
    self.fstName.text    = @"";
    self.lstName.text    = @"";
    self.emailTxt.text   = @"";
    self.passTxt.text    = @"";
    self.conPasTxt.text  = @"";
    self.telpTxt.text    = @"";
    self.mobileTxt.text  = @"";
    self.addressTxt.text = @"";
    self.cityTxt.text    = @"";
    self.zipCodeTxt.text = @"";
    self.countryTxt.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
