//
//  User_Init.m
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "User_Init.h"


@implementation User (User_Init)

+ (User *)userWithName:(NSString *)name 
            withGender:(NSString *)gender
             withEmail:(NSString *)email
             withMoney:(int)money
               withPet:(Pet *)pet
             withFoods:(NSSet *)foods
           withWeapons:(NSSet *)weapons
         withMedicines:(NSSet *)medicines
inManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Name = %@", name];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (!fetchedObjects || (fetchedObjects.count > 1)) {
        // handle error
    } else {
        user = [fetchedObjects lastObject];
        if (!user) {
            user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
            user.Name = name;
            user.Gender = gender;
            user.Email = email;
            user.Money = [NSNumber numberWithInt:money];
            user.hasPet = pet;
            user.hasFood = foods;
            user.hasWeapon = weapons;
            user.hasMedicine = medicines;
            
            // if we recently scheduled an autosave, cancel it
            [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(autosave:) object:context];
            // request a new autosave in a few tenths of a second
            [self performSelector:@selector(autosave:) withObject:context afterDelay:0.2];
        }
    }
    return user;
}


// saves a NSManagedObjectContext
// this is performed "after delay," so if a batch of them happen all at the same
//   time, only the last one will actually take effect (since previous ones get canceled)

+ (void)autosave:(id)context
{
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Error in initializing user: %@ %@", [error localizedDescription], [error userInfo]);
    }
}

@end
