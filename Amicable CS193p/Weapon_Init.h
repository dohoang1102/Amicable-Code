//
//  Weapon_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"


@interface Weapon (Weapon_Init)

+ (Weapon *)weaponWithName:(NSString *)name 
           withDescription:(NSString *)description
                 withImage:(NSData *)imageData
                 withPrice:(double)price
                  withType:(NSString *)typeOfWeapon
          withAttackPoints:(double)attackPoints
                 withCount:(double)count
inManagedObjectContext:(NSManagedObjectContext *)context;

@end
