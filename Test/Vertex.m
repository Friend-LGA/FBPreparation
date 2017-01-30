//
//  Vertex.m
//  Test
//
//  Created by Grigory Lutkov on 28/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (instancetype)initWithLabel:(NSString *)label {
    self = [super init];
    if (self) {
        self.label = label;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[Vertex allocWithZone:zone] initWithLabel:self.label];
}

@end
