//
//  Pet_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface Pet (Pet_Init)

+ (Pet *)petWithName:(NSString *)name  
       withTypeOfPet:(NSString *)typeOfPet
        withBirthday:(NSDate *)birthday
          withHealth:(double)health
       withHappiness:(double)happiness
     withHungerLevel:(double)hungerLevel
       withImageData:(NSData *)imageData
              isSick:(int)isSick
inManagedObjectContext:(NSManagedObjectContext *)context;


+ (void)setPetImageForPetWithName:(NSString *)petName withImageData:(NSData *)petImageData inContext:(NSManagedObjectContext *)context;

@end
