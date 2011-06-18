//
//  ExploreViewController.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 5/30/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ExploreViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) User *user;

@end
