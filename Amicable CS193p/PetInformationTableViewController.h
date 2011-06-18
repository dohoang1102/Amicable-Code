//
//  PetInformationTableViewController.h
//  Amicable CS193p
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@class PetInformationTableViewController;

@protocol PetInformationTableViewControllerDelegate
-(void)petInfoTableViewController:(PetInformationTableViewController *)sender
                   didSelectField:(NSString *)field;
@end

@interface PetInformationTableViewController : UITableViewController
@property (nonatomic, retain) Pet *pet;
@property (assign) id <PetInformationTableViewControllerDelegate> delegate;

@end
