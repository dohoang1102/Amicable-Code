//
//  PetPreviewController.h
//  Amicable CS193p
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HSFrameAnimator.h"
#import "PetInformationTableViewController.h"
#import "DemoAppViewController.h"
#import "User.h"
#import "AppInfoViewController.h"

@interface PetPreviewController : UIViewController <PetInformationTableViewControllerDelegate, AppInfoViewControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) User *user;

@end
