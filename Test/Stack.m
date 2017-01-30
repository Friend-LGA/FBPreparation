//
//  Stack.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Stack.h"

@interface Stack ()

@property (strong, nonatomic) NSMutableArray *contentArray;

@end

@implementation Stack

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentArray = [NSMutableArray new];
    }
    return self;
}

- (NSObject *)top {
    return self.contentArray.lastObject;
}

- (void)push:(NSObject *)object {
    [self.contentArray addObject:object];
}

- (NSObject *)pop {
    NSObject *lastObject = self.contentArray.lastObject;

    [self.contentArray removeLastObject];

    return lastObject;
}

- (NSUInteger)count {
    return self.contentArray.count;
}

- (NSString *)description {
    return self.contentArray.description;
}

@end
