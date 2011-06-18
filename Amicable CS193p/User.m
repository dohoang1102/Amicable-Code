//
//  User.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import "User.h"
#import "Food.h"
#import "Medicine.h"
#import "Pet.h"
#import "Weapon.h"


@implementation User
@dynamic Gender;
@dynamic Money;
@dynamic Name;
@dynamic Email;
@dynamic hasPet;
@dynamic hasMedicine;
@dynamic hasFood;
@dynamic hasWeapon;


- (void)addHasMedicineObject:(Medicine *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasMedicine"] addObject:value];
    [self didChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHasMedicineObject:(Medicine *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasMedicine"] removeObject:value];
    [self didChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHasMedicine:(NSSet *)value {    
    [self willChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasMedicine"] unionSet:value];
    [self didChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHasMedicine:(NSSet *)value {
    [self willChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasMedicine"] minusSet:value];
    [self didChangeValueForKey:@"hasMedicine" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addHasFoodObject:(Food *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasFood"] addObject:value];
    [self didChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHasFoodObject:(Food *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasFood"] removeObject:value];
    [self didChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHasFood:(NSSet *)value {    
    [self willChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasFood"] unionSet:value];
    [self didChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHasFood:(NSSet *)value {
    [self willChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasFood"] minusSet:value];
    [self didChangeValueForKey:@"hasFood" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addHasWeaponObject:(Weapon *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasWeapon"] addObject:value];
    [self didChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHasWeaponObject:(Weapon *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"hasWeapon"] removeObject:value];
    [self didChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHasWeapon:(NSSet *)value {    
    [self willChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasWeapon"] unionSet:value];
    [self didChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHasWeapon:(NSSet *)value {
    [self willChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"hasWeapon"] minusSet:value];
    [self didChangeValueForKey:@"hasWeapon" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
