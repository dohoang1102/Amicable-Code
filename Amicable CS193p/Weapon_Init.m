//
//  Weapon_Init.m
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "Weapon_Init.h"


@implementation Weapon (Weapon_Init)

+ (Weapon *)weaponWithName:(NSString *)name 
           withDescription:(NSString *)description
                 withImage:(NSData *)imageData
                 withPrice:(double)price
                  withType:(NSString *)typeOfWeapon
          withAttackPoints:(double)attackPoints
                 withCount:(double)count
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    Weapon *weapon = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Name = %@", name];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (!fetchedObjects || (fetchedObjects.count > 1)) {
        // handle error
    } else {
        weapon = [fetchedObjects lastObject];
        if (!weapon) {
            weapon = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
            weapon.Name = name;
            weapon.Description = description;
            weapon.Price = [NSNumber numberWithDouble:price];
            weapon.AttackPoint = [NSNumber numberWithDouble:attackPoints];
            weapon.Image = imageData;
            weapon.TypeOfWeapon = typeOfWeapon;
            weapon.Count = [NSNumber numberWithInt:count];
            
            // if we recently scheduled an autosave, cancel it
            [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(autosave:) object:context];
            // request a new autosave in a few tenths of a second
            [self performSelector:@selector(autosave:) withObject:context afterDelay:0.2];
        }
    }
    
    return weapon;
}

// saves a NSManagedObjectContext
// this is performed "after delay," so if a batch of them happen all at the same
//   time, only the last one will actually take effect (since previous ones get canceled)

+ (void)autosave:(id)context
{
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Error in initializing weapon: %@ %@", [error localizedDescription], [error userInfo]);
    }
}

// can be used to create alphabetical sections in a Photographer table
//   as long as said table is sorted case insensitively by name

- (NSString *)group
{
    if (self.Name.length > 0) {
        return [[self.Name substringToIndex:1] capitalizedString];
    } else {
        return @"";
    }
}

@end
