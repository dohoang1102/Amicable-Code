//
//  User_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Pet.h"

@interface User (User_Init)

+ (User *)userWithName:(NSString *)name 
            withGender:(NSString *)gender
             withEmail:(NSString *)email
             withMoney:(int)money
               withPet:(Pet *)pet
             withFoods:(NSSet *)foods
           withWeapons:(NSSet *)weapons
         withMedicines:(NSSet *)medicines
            inManagedObjectContext:(NSManagedObjectContext *)context;

@end
