//
//  SingaltonClass.m
//  Pizzaness
//
//  Created by wserve on 6/11/15.
//  Copyright (c) 2015 Siraj. All rights reserved.
//

#import "SingaltonClass.h"

static SingaltonClass *sharedInstance = nil;

@implementation SingaltonClass
@synthesize singletonArray,loginDetailDic,numTxtArray,numValue,seltStr;
@synthesize allDataArray;

+ (SingaltonClass *)sharedInstance

{
    if (sharedInstance == nil)
    {
        sharedInstance = [[SingaltonClass alloc]init];
    }
    
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        
        allDataArray   = [[NSMutableArray alloc]init];
        singletonArray = [[NSMutableArray alloc]init];
        loginDetailDic = [[NSMutableDictionary alloc]init];
        numTxtArray    = [[NSMutableArray alloc]init];
        numValue       = [[NSMutableArray alloc]init];
        seltStr        = [[NSMutableString alloc]init];
    }
    
    return self;
}

@end
