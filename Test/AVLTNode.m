//
//  AVLTNode.m
//  Test
//
//  Created by Grigory Lutkov on 25/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "AVLTNode.h"

@implementation AVLTNode

- (BSTNode *)addNodeWithValue:(NSObject *)value {
    AVLTNode *node = (AVLTNode *)[super addNodeWithValue:value];

    AVLTNode *grandparentNode = (AVLTNode *)node.parentNode.parentNode;

    if (!grandparentNode) {
        return node;
    }

    NSUInteger grandparentBalance = grandparentNode.balance;

    if (grandparentBalance < 2) {
        return node;
    }

    BSTNode *nodeLL = grandparentNode.leftNode ? grandparentNode.leftNode.leftNode : nil;
    BSTNode *nodeRR = grandparentNode.rightNode ? grandparentNode.rightNode.rightNode : nil;
    BSTNode *nodeLR = grandparentNode.leftNode ? grandparentNode.leftNode.rightNode : nil;
    BSTNode *nodeRL = grandparentNode.rightNode ? grandparentNode.rightNode.leftNode : nil;

    // Left Left Rotate
    if (node == nodeLL) {
        [node rotateLL];
    }
    // Right Right Rotate
    else if (node == nodeRR) {
        [node rotateRR];
    }
    // Left Right Rotate
    else if (node == nodeLR) {
        [node rotateLR];
    }
    // Right Left Rotate
    else if (node == nodeRL) {
        [node rotateRL];
    }

    return node;
}

- (NSUInteger)balance {
    NSInteger result = (self.leftNode ? self.leftNode.height : 0) - (self.rightNode ? self.rightNode.height : 0);

    return labs(result);
}

- (void)rotateLL {
    BSTNode *parentNode = self.parentNode;
    BSTNode *grandparentNode = parentNode.parentNode;
    BSTNode *grandGranParent = grandparentNode.parentNode;

    if (grandparentNode == grandGranParent.leftNode) {
        grandGranParent.leftNode = parentNode;
    }
    else {
        grandGranParent.rightNode = parentNode;
    }

    parentNode.rightNode = grandparentNode;
}

- (void)rotateRR {
    BSTNode *parentNode = self.parentNode;
    BSTNode *grandparentNode = parentNode.parentNode;
    BSTNode *grandGranParent = grandparentNode.parentNode;

    if (grandparentNode == grandGranParent.leftNode) {
        grandGranParent.leftNode = parentNode;
    }
    else {
        grandGranParent.rightNode = parentNode;
    }

    parentNode.leftNode = grandparentNode;
}

- (void)rotateLR {
    AVLTNode *parentNode = (AVLTNode *)self.parentNode;
    AVLTNode *grandparentNode = (AVLTNode *)parentNode.parentNode;

    grandparentNode.leftNode = self;
    self.leftNode = parentNode;

    [parentNode rotateLL];
}

- (void)rotateRL {
    AVLTNode *parentNode = (AVLTNode *)self.parentNode;
    AVLTNode *grandparentNode = (AVLTNode *)parentNode.parentNode;

    grandparentNode.rightNode = self;
    self.rightNode = parentNode;

    [parentNode rotateRR];
}

@end
