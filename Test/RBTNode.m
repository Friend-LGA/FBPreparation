//
//  RBTNode.m
//  Test
//
//  Created by Grigory Lutkov on 25/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "RBTNode.h"

@implementation RBTNode

- (BOOL)isRed {
    return self.color == RBTNodeColorRed;
}

- (BOOL)isBlack {
    return self.color == RBTNodeColorBlack;
}

- (RBTNode *)addNodeWithValue:(NSObject *)value {
    if (self.isRoot) self.color = RBTNodeColorBlack;

    RBTNode *node = (RBTNode *)[super addNodeWithValue:value];

    [self repairFromNode:node];

    return node;
}

- (void)repairFromNode:(RBTNode *)node {
    if (node.isRoot) {
        node.color = RBTNodeColorBlack;
        return;
    }

    RBTNode *parentNode = (RBTNode *)node.parentNode;

    if (parentNode.isBlack) {
        return;
    }

    RBTNode *grandparentNode = (RBTNode *)parentNode.parentNode;
    RBTNode *uncleNode = nil;

    if (grandparentNode.leftNode != parentNode) {
        uncleNode = (RBTNode *)grandparentNode.leftNode;
    }
    else {
        uncleNode = (RBTNode *)grandparentNode.rightNode;
    }

    if (uncleNode.isRed) {
        grandparentNode.color = RBTNodeColorRed;
        parentNode.color = RBTNodeColorBlack;
        uncleNode.color = RBTNodeColorBlack;

        [self repairFromNode:grandparentNode];
        return;
    }

    // A lot more calculations...
}

@end
