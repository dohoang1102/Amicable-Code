//
//  Medicine_Init.h
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Medicine.h"

@interface Medicine (Medicine_Init)

+ (Medicine *)medicineWithName:(NSString *)name
               withDescription:(NSString *)description
                     withImage:(NSData *)image
                     withPrice:(double)price
                     withCount:(double)count
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
