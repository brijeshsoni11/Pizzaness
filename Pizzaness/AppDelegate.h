//
//  AppDelegate.h
//  Pizzaness
//
//  Created by wserve on 5/27/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <CoreData/CoreData.h>

#ifdef FD_TESTING               // These creds are for the SampleCharge-Testing target
#define kApiKey             @"y6pWAJNyJyjGv66IsVuWnklkKUPFbb0a" //replace this with your Payeezy API Key
#define kApiSecret          @"86fbae7030253af3cd15faef2a1f4b67353e41fb6799f576b5093ae52901e6f7" //replace this with your Payeezy API Secret
#define kMerchantToken      @"fdoa-a480ce8951daa73262734cf102641994c1e55e7cdf4c02b6" //replace this with your Payeezy Token
#define kApplePayMerchantId @"mock-1" //replace with your merchantID created on Apple Dev Site

// Point to the test Environment
#define kEnvironment @"CERT"
#else                           // These creds are for the SampleCharge-iPhone6 Target


//#error Payeezy credentials have not been configured
//#error You must supply the Payeezy credentials and Apple Pay™ Merchant ID assigned to your App ID
//#error To get your own Payeezy credentials, go to  @ "https://developer.payeezy.com"

#define kApiKey             @"your Payeezy API Key" //replace this with your Payeezy API Key
#define kApiSecret          @"Your Payeezy API Secret" //replace this with your Payeezy API Secret
#define kMerchantToken      @"Your Payeezy Token" //replace this with your Payeezy Token
#define kApplePayMerchantId @"merchant.com.Your ApplePay Merchant ID" //replace with the merchantID assigned to this app on the Apple Developer Site

// Point to the PROD Environment
#define kEnvironment @"PROD"

#endif

@class FDInAppPaymentProcessor;

@interface AppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FDInAppPaymentProcessor *pePaymentProcessor;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
