//
//  Disease_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Disease.h"

@interface Disease (Disease_Init)

+ (Disease *)diseaseWithName:(NSString *)name 
       withDescription:(NSString *)description
       withEffectPoint:(double)effectPoint
inManagedObjectContext:(NSManagedObjectContext *)context;

@end
