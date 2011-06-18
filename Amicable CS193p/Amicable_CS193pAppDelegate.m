//
//  Amicable_CS193pAppDelegate.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong and Jim ZHeng on 5/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
// 
//

#import "Amicable_CS193pAppDelegate.h"
#import "PetPreviewController.h"
#import "InventoryTableViewController.h"
#import "InitializeObjectsIntoDB.h"
#import "BrowseBackgroundViewController.h"
#import "ExploreViewController.h"

@implementation Amicable_CS193pAppDelegate

@synthesize window=_window;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

@synthesize fblvc;

static NSString *userKey = @"userKey";
static NSString *dummyUser = @"Tester";

#pragma mark - App Initialization 

-(void)InitializeApplicationData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *didOpenForFirstTime = [defaults objectForKey:@"didOpenForFirstTime"];
    NSString *userName = [defaults objectForKey:userKey];
    
    if([didOpenForFirstTime intValue] != 1)
    {
        [InitializeObjectsIntoDB initializeObjectsForUser:userName InManagedContext:self.managedObjectContext];
        didOpenForFirstTime = [NSNumber numberWithInt:1];
        [defaults setObject:didOpenForFirstTime forKey:@"didOpenForFirstTime"];
        [defaults synchronize];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Initialize FBLogin View Controller here so we can handle the incoming application URL Open
    if(!self.fblvc) self.fblvc = [[DemoAppViewController alloc] init];
    [self.fblvc setTitle:@"Welcome!"];
    self.fblvc.delegate = self;
    //[self.window addSubview:self.fblvc.view];
    self.window.rootViewController = self.fblvc;
    [self.window makeKeyAndVisible];    
    [self.fblvc release];
    
    // Initialize the application data if the application is happening for the first time
    NSLog(@"App is lauched!");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)dealloc
{
    [fblvc release];
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Amicable_CS193p" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Amicable_CS193p.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}
#pragma mark - DemoAppViewController delegation

#define USER_ENTITY_NAME @"User"

- (User *)getUserEntity
{
    User *user;
    if (self.managedObjectContext) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:USER_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
        //fetchRequest.sortDescriptors = NULL;
        NSError *error;
        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        user = (User *)[fetchedObjects lastObject];
        NSLog(@"Fetched request has : %d", [fetchedObjects count]);
        [fetchRequest release];
    }
    NSLog(@"User's name when retrieving is : %@", user.Name);
    return user;
}

-(void)demoAppViewControllerLoggedIn:(DemoAppViewController *)sender
{  
    // create dummy user name
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dummyUser forKey:userKey];
    [defaults synchronize];
    
    // Before we do anything else, initialize the game data from Bundle info.
    [self InitializeApplicationData];
    User *user = [self getUserEntity];
       
    UITabBarController *tbc = [[UITabBarController alloc] init];
        
    static NSString *exploreViewTitle = @"Explore";
    static NSString *inventoryViewTitle = @"Inventory";
    
    // Pet tab
    PetPreviewController *pvc = [[PetPreviewController alloc] init];
    pvc.user = user;
    pvc.context = self.managedObjectContext;
    UINavigationController *pvcNavCon = [[UINavigationController alloc] initWithRootViewController:pvc];
    [pvcNavCon.navigationBar setTintColor:[UIColor blackColor]];
    [pvc release];
    pvcNavCon.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Pet" image:[UIImage imageNamed:@"dogpaw.png"] tag:0] autorelease];
    
    // Explore Tab
    ExploreViewController *evc = [[ExploreViewController alloc] init];
    evc.title = exploreViewTitle;
    evc.user = user;
    evc.context = self.managedObjectContext;
    UINavigationController *exploreNC = [[UINavigationController alloc] initWithRootViewController:evc];
    [exploreNC.navigationBar setTintColor:[UIColor blackColor]];
    [evc release];
    exploreNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Explore" image:[UIImage imageNamed:@"compass.png"] tag:0] autorelease]; 
    
    // Inventory Tab
    InventoryTableViewController *itvc = [[InventoryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    itvc.title = inventoryViewTitle;
    itvc.user = user;
    itvc.context = self.managedObjectContext;
    UINavigationController *itvcNavCon = [[UINavigationController alloc] initWithRootViewController:itvc];
    [itvcNavCon.navigationBar setTintColor:[UIColor blackColor]];
    [itvc release];
    itvcNavCon.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Inventory" image:[UIImage imageNamed:@"shoppingcart.png"] tag:0] autorelease];
    
    // Finish all tab bar controllers
    tbc.viewControllers = [NSArray arrayWithObjects:pvcNavCon, exploreNC, itvcNavCon, nil];
    [pvcNavCon release]; [itvcNavCon release];
    
    if(self.window.rootViewController) [self.window.rootViewController release];
    self.window.rootViewController = tbc;
    [tbc release];
    
    [self.window makeKeyAndVisible];
    NSLog(@"View appeared!");
}


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Handling Facebook redirect
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[self.fblvc facebook] handleOpenURL:url];
}

@end
