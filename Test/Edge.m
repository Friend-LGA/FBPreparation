//
//  Edge.m
//  Test
//
//  Created by Grigory Lutkov on 29/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Edge.h"

@implementation Edge

- (instancetype)initFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    self = [super init];
    if (self) {
        self.fromVertex = fromVertex;
        self.toVertex = toVertex;
    }
    return self;
}

@end
