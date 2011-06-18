//
//  Amicable_CS193pAppDelegate.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 5/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoAppViewController.h"

@interface Amicable_CS193pAppDelegate : NSObject <UIApplicationDelegate, DemoAppViewControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) DemoAppViewController *fblvc;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
