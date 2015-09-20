//
//  SingaltonClass.h
//  Pizzaness
//
//  Created by wserve on 6/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingaltonClass : NSObject

@property (nonatomic, strong) NSMutableArray *singletonArray;
@property (nonatomic, strong) NSMutableDictionary *loginDetailDic
;

@property(nonatomic, retain)NSMutableArray* allDataArray;
@property (nonatomic, strong) NSMutableArray *numTxtArray;
@property(nonatomic ,strong)NSMutableArray *numValue;
+ (SingaltonClass*)sharedInstance;
@property(strong,nonatomic)NSMutableString *seltStr;
@end
