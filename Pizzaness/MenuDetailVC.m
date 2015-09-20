//
//  MenuDetailVC.m
//  Pizzaness
//
//  Created by wserve on 8/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "MenuDetailVC.h"
#import "MenuDetailCell.h"
#import "AddCartViewController.h"
#import "SingaltonClass.h"

@interface MenuDetailVC ()
@property(strong)NSMutableData *data;
@property(strong)NSDictionary *dictResult;
@property(strong)NSArray *array;
@property(strong)NSDictionary *dictFinal;
@end
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION     = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION     = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT    = 158;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT   = 162;
@implementation MenuDetailVC


- (void)viewDidLoad
{
    
    NSLog(@"dicvalue are %@",self.dicArry);
    
    sharedSingleton = [SingaltonClass sharedInstance];
    
    [sharedSingleton.allDataArray addObject:self.dicArry];
    
    NSString *imgString    =[self.dicArry objectForKey:@"Image"];
    
    NSURL *imageURL = [NSURL URLWithString:imgString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.intVAL =[[NSString alloc]init];
    self.menuImge.image    =image;
    self.titleName.text    =[self.dicArry objectForKey:@"Title"];
    self.discriptnLbl.text =[self.dicArry objectForKey:@"Description"];
    
        xtraLarge  =[self.dicArry objectForKey:@"xlarge_price"];
        largeStr =[self.dicArry objectForKey:@"large_price"];
        mediumStr =[self.dicArry objectForKey:@"medium_price"];
        smallStr =[self.dicArry objectForKey:@"small_price"];
    
      NSString *valX =@"10'Small";
      NSString *valL =@"12'Medium";
      NSString *valM =@"14'Large";
      NSString *valS =@"16'XLarge";

     arrData =[[NSArray alloc]init];
     arrData =[[NSArray alloc]initWithObjects:smallStr,mediumStr,largeStr,xtraLarge,nil];
    
    pizzaTypeArr =[[NSArray alloc]initWithObjects:valX,valL,valM,valS,nil];
    
       
       if([checkVal isEqual:@"abc"])
           {
    
               NSString *strval=  [[NSUserDefaults standardUserDefaults]objectForKey:@"price"];
               NSString *strval2=  [[NSUserDefaults standardUserDefaults]objectForKey:@"newprice"];
              float intp =[strval intValue];
                float intpr =[strval2 floatValue];
               float totalInt =intp*intpr;
               NSString *str = [NSString stringWithFormat:@"%f", totalInt];
               self.priceLblTxt.text = str;
           }
           else
           {
              
              self.priceLblTxt.text = valX;
    
           }

    
    self.menuScrollView.contentSize=CGSizeMake(320,1650);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.sections =[[NSArray alloc]init];
    self.sectionAnimals  =[[NSMutableArray alloc]init];
    
    self.itemArray  =[[NSMutableArray alloc]init];
    
    NSURL *url=[[NSURL alloc]initWithString:@"http://wserve.org/us/pizzaness/api/toppings.php"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    [super viewDidLoad];

   
    [self resetToppingsInCoreData];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    
    return [arrData count];
    
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pizzaTypeArr objectAtIndex:row];
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.pizzaTypeField.text = [pizzaTypeArr objectAtIndex:row];
    
    // self.pizzaTypeField.text = [arrData objectAtIndex:row];
    
    self.priceLblTxt.text =[arrData objectAtIndex:row];
    
   
    
}

-(void)pickerDoneClicked
{
    NSString *newStr =self.priceLblTxt.text;
    
    [[NSUserDefaults standardUserDefaults]setObject:newStr forKey:@"newprice"];
    
    self.titleName.text =self.pizzaTypeField.text;
    [self.pizzaTypeField resignFirstResponder];
    profileToolBar.hidden = NO;
    productProfilePickerView.hidden = NO;
    
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
    
    self.sections = [self.dictResult objectForKey:@"Category"];
    
   
    self.itemArray = [[NSMutableArray alloc]init];
    
    for (int i =0 ; i < [self.sections count]; i++)
        
    {
        NSString *stVal =[[self.sections objectAtIndex:i]objectForKey:@"Title_Category"];
        
        [self.sectionAnimals addObject:stVal];
        
        NSMutableArray *itemarray = [[NSMutableArray alloc]init];
       itemarray= [[self.sections objectAtIndex:i]objectForKey:@"item"];
        
//        for (int j = 0; j<mutArr.count; j++) {
//            
//            
//        }
        //[itemarray addObject:myarray];
        
        [self.itemArray addObject:itemarray];
        
    }
    NSLog(@"section array array %@",self.sectionAnimals);

    NSLog(@"item array %@",self.itemArray);
    
    [self.menuTblView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.itemArray[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellidentifier = @"MenuDetail";
    
    MenuDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[MenuDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    [cell.leftHalfButtn setSelected:NO];
    [cell.fullButton setSelected:NO];
    [cell.rightHalfButtn setSelected:NO];
    [cell.otherButton setSelected:NO];
    [cell.noneBtnActn setSelected:NO];
    
     NSMutableArray *teams =_itemArray[indexPath.section];
     NSString *text = [teams[indexPath.item] objectForKey:@"Title"];
     cell.textLabel.text = text;
    
    
    cell.leftHalfButtn.tag = 0;
    cell.fullButton.tag = 1;
    cell.rightHalfButtn.tag = 2;
    cell.otherButton.tag = 3;
    
    [cell setIndexPath:indexPath];
    [cell setDelegate:self];
    
    
    
    
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Toppings"];
    
        // Two predicate filters: last_name and age
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"coloum = %@ && row = %@",[NSString stringWithFormat:@"%ld",(long)indexPath.section], [NSString stringWithFormat:@"%ld",(long)indexPath.row] ];
        [fetchRequest setPredicate:predicate];
    
    
        [fetchRequest setReturnsObjectsAsFaults:NO];
    
        NSArray *fetchToppings = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
        //NSLog(@"section = %ld and row =%ld have =%@",(long)indexPath.section,(long)indexPath.row,fetchToppings);
    
        if (fetchToppings.count != 0)
        {
            NSManagedObject *managedObject = [fetchToppings objectAtIndex:0];
            if ([[managedObject valueForKey:@"leftHalfTopping"] integerValue] == 1 && [[managedObject valueForKey:@"coloum"] integerValue] == indexPath.section && [[managedObject valueForKey:@"row"] integerValue] == indexPath.row)
            {
                // NSLog(@"section = %ld and row =%ld have =%@",indexPath.section,indexPath.row,fetchToppings);
                [cell.leftHalfButtn setSelected:YES];
                [cell.leftHalfButtn setImage:[UIImage imageNamed:@"green4.png"] forState:UIControlStateSelected];
                
            }
            else
            {
                 [cell.leftHalfButtn setSelected:NO];
                 [cell.leftHalfButtn setImage:[UIImage imageNamed:@"circle4.png"] forState:UIControlStateNormal];
            }
            
            if ([[managedObject valueForKey:@"fullTopping"] integerValue] == 1 && [[managedObject valueForKey:@"coloum"] integerValue] == indexPath.section && [[managedObject valueForKey:@"row"] integerValue] == indexPath.row)
            {
                [cell.fullButton setSelected:YES];
                [cell.fullButton setImage:[UIImage imageNamed:@"green3.png"] forState:UIControlStateSelected];
            }
            else
            {
                [cell.fullButton setSelected:NO];
                [cell.fullButton setImage:[UIImage imageNamed:@"circle3.png"] forState:UIControlStateNormal];
            }
            
            if ([[managedObject valueForKey:@"rightHalfTopping"] integerValue] == 1 && [[managedObject valueForKey:@"coloum"] integerValue] == indexPath.section && [[managedObject valueForKey:@"row"] integerValue] == indexPath.row)
            {
                [cell.rightHalfButtn setSelected:YES];
                [cell.rightHalfButtn setImage:[UIImage imageNamed:@"green2.png"] forState:UIControlStateSelected];
            }
            else
            {
                [cell.rightHalfButtn setSelected:NO];
                [cell.rightHalfButtn setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            }
            
            if ([[managedObject valueForKey:@"otherTopping"] integerValue] == 1 && [[managedObject valueForKey:@"coloum"] integerValue] == indexPath.section && [[managedObject valueForKey:@"row"] integerValue] == indexPath.row)
            {
                [cell.otherButton setSelected:YES];
                [cell.otherButton setImage:[UIImage imageNamed:@"green5.png"] forState:UIControlStateSelected];
            }
            else
            {
                [cell.otherButton setSelected:NO];
                [cell.otherButton setImage:[UIImage imageNamed:@"circle5.png"] forState:UIControlStateNormal];
            }
            
        }
    
   
    return cell;
    
}

-(void)selectToppingsButtonsIntexTapped:(NSIndexPath *)indexPath ofCustomCell:(MenuDetailCell *)cell
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newTopping = nil;
   

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Toppings"];
    // Two predicate filters: last_name and age
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"coloum = %@ && row = %@",[NSString stringWithFormat:@"%ld",(long)indexPath.section], [NSString stringWithFormat:@"%ld",(long)indexPath.row] ];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSArray *fetchToppings = [context executeFetchRequest:fetchRequest error:nil];

    if (fetchToppings.count != 0)
    {
        // oki hai
        newTopping = [fetchToppings objectAtIndex:0];
    }
    else
    {
        // Create a new managed object
         newTopping = [NSEntityDescription insertNewObjectForEntityForName:@"Toppings" inManagedObjectContext:context];
        [newTopping setValue:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forKey:@"coloum"];
        [newTopping setValue:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"row"];
    }
    
    
   
    if ([cell.leftHalfButtn isSelected])
    {
         [newTopping setValue:@"1" forKey:@"leftHalfTopping"];
    }
    else
    {
         [newTopping setValue:@"0" forKey:@"leftHalfTopping"];
    }
    
    if ([cell.fullButton isSelected])
    {
        [newTopping setValue:@"1" forKey:@"fullTopping"];
    }
    else
    {
        [newTopping setValue:@"0" forKey:@"fullTopping"];
    }
    
    if ([cell.rightHalfButtn isSelected])
    {
        [newTopping setValue:@"1" forKey:@"rightHalfTopping"];
    }
    else
    {
        [newTopping setValue:@"0" forKey:@"rightHalfTopping"];
    }
    
    if ([cell.otherButton isSelected])
    {
        [newTopping setValue:@"1" forKey:@"otherTopping"];
    }
    else
    {
        [newTopping setValue:@"0" forKey:@"otherTopping"];
    }
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSLog(@"Save");
    }
    
}
-(void)selectNoneButtonAtIndexTapped:(NSIndexPath *)indexPath ofCustomCell:(MenuDetailCell *)cell
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Toppings"];
    // Two predicate filters: last_name and age
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"coloum = %@ && row = %@",[NSString stringWithFormat:@"%ld",(long)indexPath.section], [NSString stringWithFormat:@"%ld",(long)indexPath.row] ];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setReturnsObjectsAsFaults:NO];
     NSArray *fetchToppings = [context executeFetchRequest:fetchRequest error:nil];
    
    if (fetchToppings.count != 0)
    {
        NSManagedObject *topping = [fetchToppings lastObject];
        [context deleteObject:topping];
        [self.menuTblView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UIView *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _sections[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *label = [UILabel new];
    label.text = [@"  " stringByAppendingString:_sectionAnimals[section]];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor =[UIColor colorWithRed:(2/255.f) green:(165/255.f) blue:(214/255.f) alpha:1.0f];
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.menuScrollView setContentOffset:CGPointMake(0,160)];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.menuScrollView  setContentOffset:CGPointMake(0,168)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
         [self selectTextField];
    [self slideViewUpForTextField:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];

}

-(void) textFieldDidEndEditing:(UITextField*) textField

{
    checkVal = @"abc";
   
    self.intVAL = self.quatityTxt.text;
    
     [[NSUserDefaults standardUserDefaults]setObject:self.intVAL forKey:@"price"];
    
    [self viewDidLoad];

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

-(void)selectTextField
{
    
    productProfilePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,310,150,150)];
    productProfilePickerView.showsSelectionIndicator = YES;
    productProfilePickerView.hidden = NO;
    
    productProfilePickerView.delegate = self;
    productProfilePickerView.backgroundColor = [UIColor clearColor];
    productProfilePickerView.tag = 1;
    profileToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,56)];
    
    profileToolBar.barStyle = UIBarStyleBlackOpaque;
    
    [profileToolBar sizeToFit];
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    
    [profileToolBar setItems:barItems animated:YES];
    
    self.pizzaTypeField.inputAccessoryView = profileToolBar;
    [self.pizzaTypeField setInputView:productProfilePickerView];
}

- (IBAction)addToCartBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddCartViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"AddCart"];
    [self.navigationController pushViewController:mainview animated:YES];

      
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)resetToppingsInCoreData
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Toppings"];
    NSArray *fetchToppings = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (fetchToppings.count !=0)
    {
        for ( NSManagedObject * object in fetchToppings) {
            [managedObjectContext deleteObject:object];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
