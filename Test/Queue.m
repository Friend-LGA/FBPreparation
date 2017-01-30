//
//  Queue.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Queue.h"

@interface Queue ()

@property (strong, nonatomic) NSMutableArray *contentArray;

@end

@implementation Queue

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentArray = [NSMutableArray new];
    }
    return self;
}

- (NSObject *)first {
    return self.contentArray.firstObject;
}

- (NSObject *)last {
    return self.contentArray.lastObject;
}

- (void)enqueue:(NSObject *)object {
    [self.contentArray addObject:object];
}

- (NSObject *)dequeue {
    NSObject *firstObject = self.first;

    [self.contentArray removeObjectAtIndex:0];

    return firstObject;
}

- (NSUInteger)count {
    return self.contentArray.count;
}

- (NSString *)description {
    return self.contentArray.description;
}

@end
