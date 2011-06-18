//
//  Food_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface Food (Food_Init)

+ (Food *)foodWithName:(NSString *)name 
       withDescription:(NSString *)description
             withImage:(NSData *)imageData
             withPrice:(double)price
       withEffectPoint:(double)effectPoint
             withCount:(double)count
inManagedObjectContext:(NSManagedObjectContext *)context;

@end
