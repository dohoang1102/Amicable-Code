//
//  ItemViewController.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 5/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ItemViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) id item;
@property (nonatomic, retain) User *user;

@end