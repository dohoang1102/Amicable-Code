//
//  ItemTableViewController.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ItemTableViewController : UITableViewController

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) User *user;

@end
