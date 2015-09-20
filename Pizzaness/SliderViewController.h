//
//  SliderViewController.h
//  D B Malorey
//
//  Created by wserve on 4/29/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController<NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *mutArray;
    NSArray *nsArray;
    NSDictionary *dict;
    NSMutableArray *imgArry;
    NSString *check;

}
@property (weak, nonatomic) IBOutlet UITableView *tableViewSl;

@end
