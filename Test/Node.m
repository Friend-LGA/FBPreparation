//
//  Node.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Node.h"

@implementation Node

- (nonnull instancetype)initWithValue:(nullable NSObject *)value {
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}

- (void)setChildNode:(Node *)childNode {
    _childNode = childNode;

    if (![childNode.parentNode isEqual:self]) {
        childNode.parentNode = self;
    }
}

- (void)setParentNode:(Node *)parentNode {
    _parentNode = parentNode;

    if (![parentNode.childNode isEqual:self]) {
        parentNode.childNode = self;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Value: %@", self.value];
}

@end
