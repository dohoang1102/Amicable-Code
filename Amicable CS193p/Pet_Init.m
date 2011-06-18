//
//  Pet_Init.m
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "Pet_Init.h"


@implementation Pet (Pet_Init)

+ (void)setPetImageForPetWithName:(NSString *)petName withImageData:(NSData *)petImageData inContext:(NSManagedObjectContext *)context
{
    Pet *pet = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Name = %@", petName];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (!fetchedObjects || (fetchedObjects.count > 1)) {
        // handle error
    } else {
        pet = [fetchedObjects lastObject];
        if (pet) {
            pet.ImageData = petImageData;
            // if we recently scheduled an autosave, cancel it
            [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(autosave:) object:context];
            // request a new autosave in a few tenths of a second
            [self performSelector:@selector(autosave:) withObject:context afterDelay:0.2];
        }
    }

    
}

+ (Pet *)petWithName:(NSString *)name  
       withTypeOfPet:(NSString *)typeOfPet
        withBirthday:(NSDate *)birthday
          withHealth:(double)health
       withHappiness:(double)happiness
     withHungerLevel:(double)hungerLevel
       withImageData:(NSData *)imageData
              isSick:(int)isSick
inManagedObjectContext:(NSManagedObjectContext *)context
{
    Pet *pet = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Name = %@", name];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (!fetchedObjects || (fetchedObjects.count > 1)) {
        // handle error
    } else {
        pet = [fetchedObjects lastObject];
        if (!pet) {
            pet = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
            pet.Name = name;
            pet.Happiness = [NSNumber numberWithDouble:happiness];
            pet.Health = [NSNumber numberWithDouble:health];
            pet.HungerLevel = [NSNumber numberWithDouble:hungerLevel];
            pet.TypeOfPet = typeOfPet;
            pet.isSick = [NSNumber numberWithInt:isSick];
            pet.Birthday = birthday;
            pet.ImageData = imageData;
            
            // if we recently scheduled an autosave, cancel it
            [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(autosave:) object:context];
            // request a new autosave in a few tenths of a second
            [self performSelector:@selector(autosave:) withObject:context afterDelay:0.2];
        }
    }
    
    return pet;
}

// saves a NSManagedObjectContext
// this is performed "after delay," so if a batch of them happen all at the same
//   time, only the last one will actually take effect (since previous ones get canceled)

+ (void)autosave:(id)context
{
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Error in initializing pet: %@ %@", [error localizedDescription], [error userInfo]);
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
