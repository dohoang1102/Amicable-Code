//
//  Disease_Init.m
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "Disease_Init.h"


@implementation Disease (Disease_Init)

+ (Disease *)diseaseWithName:(NSString *)name 
               withDescription:(NSString *)description
               withEffectPoint:(double)effectPoint
        inManagedObjectContext:(NSManagedObjectContext *)context;
{
    Disease *disease = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"Name = %@", name];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (!fetchedObjects || (fetchedObjects.count > 1)) {
        // handle error
    } else {
        disease = [fetchedObjects lastObject];
        if (!disease) {
            disease = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
            disease.Name = name;
            disease.Description = description;
            disease.EffectPoint = [NSNumber numberWithDouble:effectPoint];
            
            // if we recently scheduled an autosave, cancel it
            [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(autosave:) object:context];
            // request a new autosave in a few tenths of a second
            [self performSelector:@selector(autosave:) withObject:context afterDelay:0.2];
        }
    }
    
    return disease;
}

// saves a NSManagedObjectContext
// this is performed "after delay," so if a batch of them happen all at the same
//   time, only the last one will actually take effect (since previous ones get canceled)

+ (void)autosave:(id)context
{
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Error in initializing disease: %@ %@", [error localizedDescription], [error userInfo]);
    }
}
@end
