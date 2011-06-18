//
//  InventoryTableViewController.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface InventoryTableViewController : UITableViewController

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) User *user;

@end
