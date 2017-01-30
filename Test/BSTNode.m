//
//  BSTNode.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "BSTNode.h"

@implementation BSTNode

- (nonnull instancetype)initWithValue:(nullable NSObject *)value {
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}

- (instancetype)initWithValue:(NSObject *)value leftNode:(BSTNode *)leftNode rightNode:(BSTNode *)rightNode {
    self = [super init];
    if (self) {
        self.value = value;
        self.leftNode = leftNode;
        self.rightNode = rightNode;
    }
    return self;
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"Value: %@", self.value];
}

- (NSString *)treeNodesDescriptionInOrder {
    return [NSString stringWithFormat:@"{left: %@, value: %@, right: %@}",
            self.leftNode.treeNodesDescriptionInOrder, self.value, self.rightNode.treeNodesDescriptionInOrder];
}

- (NSString *)treeValuesDescriptionInOrder {
    NSMutableString *string = [NSMutableString new];

    if (self.leftNode.treeValuesDescriptionInOrder) {
        [string appendString:self.leftNode.treeValuesDescriptionInOrder];
    }

    if (self.value) {
        if (string.length) {
            [string appendFormat:@", %@", self.value];
        }
        else {
            [string appendString:self.value.description];
        }
    }

    if (self.rightNode.treeValuesDescriptionInOrder) {
        if (string.length) {
            [string appendFormat:@", %@", self.rightNode.treeValuesDescriptionInOrder];
        }
        else {
            [string appendString:self.rightNode.treeValuesDescriptionInOrder.description];
        }
    }

    return string.copy;
}

#pragma mark -

- (void)setLeftNode:(BSTNode *)leftNode {
    if (self == leftNode) return;

    _leftNode = leftNode;

    if (leftNode.parentNode != self) {
        leftNode.parentNode = self;
    }

    if (leftNode == self.rightNode) {
        self.rightNode = nil;
    }

    if (leftNode == self.parentNode) {
        self.parentNode = nil;
    }
}

- (void)setRightNode:(BSTNode *)rightNode {
    if (self == rightNode) return;

    _rightNode = rightNode;

    if (rightNode.parentNode != self) {
        rightNode.parentNode = self;
    }

    if (rightNode == self.leftNode) {
        rightNode.leftNode = nil;
    }

    if (rightNode == self.parentNode) {
        rightNode.parentNode = nil;
    }
}

- (void)setParentNode:(BSTNode *)parentNode {
    if (self == parentNode) return;

    _parentNode = parentNode;

    if (parentNode == self.leftNode) {
        self.leftNode = nil;
    }

    if (parentNode == self.rightNode) {
        self.rightNode = nil;
    }
}

#pragma mark -

- (BOOL)isRoot {
    return self.parentNode == nil;
}

- (BOOL)isLeaf {
    return !self.leftNode && !self.rightNode;
}

- (BOOL)hasAnyChild {
    return self.leftNode || self.rightNode;
}

- (BOOL)hasBothChildren {
    return self.leftNode && self.rightNode;
}

#pragma mark -

- (BOOL)traverseInOrder:(void(^)(BSTNode *node, BOOL *stop))handler {
    BOOL stop = NO;

    stop = [self.leftNode traverseInOrder:handler];

    if (stop) return stop;

    handler(self, &stop);

    if (stop) return stop;

    stop = [self.rightNode traverseInOrder:handler];

    return stop;
}

- (BOOL)traversePreOrder:(void(^)(BSTNode *node, BOOL *stop))handler {
    BOOL stop = NO;

    handler(self, &stop);

    if (stop) return stop;

    stop = [self.leftNode traverseInOrder:handler];

    if (stop) return stop;

    stop = [self.rightNode traverseInOrder:handler];
    
    return stop;
}

- (BOOL)traversePostOrder:(void(^)(BSTNode *node, BOOL *stop))handler {
    BOOL stop = NO;

    stop = [self.leftNode traverseInOrder:handler];

    if (stop) return stop;

    stop = [self.rightNode traverseInOrder:handler];

    if (stop) return stop;

    handler(self, &stop);

    return stop;
}

- (NSUInteger)depth {
    NSUInteger result = 0;
    BSTNode *node = self;

    while (node) {
        result++;

        node = node.parentNode;
    }

    return result;
}

- (NSUInteger)height {
    NSUInteger leftNodeHeight = 0;
    if (self.leftNode) {
        leftNodeHeight = self.leftNode.height;
    }

    NSUInteger rightNodeHeight = 0;
    if (self.rightNode) {
        rightNodeHeight = self.rightNode.height;
    }

    return MAX(leftNodeHeight, rightNodeHeight) + 1;
}

- (BSTNode *)rootNode {
    BSTNode *node = self;

    while (YES) {
        if (!node.parentNode) break;

        node = node.parentNode;
    }

    return node;
}

- (BOOL)containsNodeWithValue:(NSObject *)value {
    return [self nodeWithValue:value] != nil;
}

- (NSArray *)nodesWithValue:(NSObject *)value {
    NSMutableArray *array = [NSMutableArray new];

    [self traverseInOrder:^(BSTNode *node, BOOL *stop) {
        if ((!value && !node.value) || [node.value isEqual:value]) {
            [array addObject:node];
        }
    }];

    return array.copy;
}

- (BSTNode *)nodeWithValue:(NSObject *)value {
    if ([value isEqualTo:self.value]) {
        return self;
    }
    else if ([value isLessThan:self.value]) {
        return [self.leftNode nodeWithValue:value];
    }
    else if ([value isGreaterThan:self.value]) {
        return [self.rightNode nodeWithValue:value];
    }
    else {
        return nil;
    }
}

- (NSArray *)allNodesInOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traverseInOrder:^(BSTNode *node, BOOL *stop) {
        [array addObject:node];
    }];

    return array.copy;
}

- (NSArray *)allNodesPreOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traversePreOrder:^(BSTNode *node, BOOL *stop) {
        [array addObject:node];
    }];

    return array.copy;
}

- (NSArray *)allNodesPostOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traversePostOrder:^(BSTNode *node, BOOL *stop) {
        [array addObject:node];
    }];

    return array.copy;
}

- (NSArray *)allValuesInOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traverseInOrder:^(BSTNode *node, BOOL *stop) {
        if (node.value) {
            [array addObject:node.value];
        }
    }];

    return array.copy;
}

- (NSArray *)allValuesPreOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traversePreOrder:^(BSTNode *node, BOOL *stop) {
        if (node.value) {
            [array addObject:node.value];
        }
    }];

    return array.copy;
}

- (NSArray *)allValuesPostOrder {
    NSMutableArray *array = [NSMutableArray new];

    [self traversePostOrder:^(BSTNode *node, BOOL *stop) {
        if (node.value) {
            [array addObject:node.value];
        }
    }];

    return array.copy;
}

- (NSUInteger)count {
    __block NSUInteger counter = 0;

    [self traverseInOrder:^(BSTNode *node, BOOL *stop) {
        counter++;
    }];

    return counter;
}

- (NSUInteger)numberOfChildren {
    NSUInteger counter = 0;

    if (self.leftNode) counter++;
    if (self.rightNode) counter++;

    return counter;
}

- (BSTNode *)addNodeWithValue:(NSObject *)value {
    BSTNode *node = nil;

    if ([value isLessThanOrEqualTo:self.value]) {
        if (self.leftNode) {
            node = [self.leftNode addNodeWithValue:value];
        }
        else {
            node = [[self.class alloc] initWithValue:value];
            self.leftNode = node;
        }
    }
    else if ([value isGreaterThanOrEqualTo:self.value]) {
        if (self.rightNode) {
            node = [self.rightNode addNodeWithValue:value];
        }
        else {
            node = [[self.class alloc] initWithValue:value];
            self.rightNode = node;
        }
    }

    return node;
}

- (void)removeNodesWithValue:(NSObject *)value {
    BSTNode *node = nil;

    while ((node = [self nodeWithValue:value])) {
        BSTNode *parentNode = node.parentNode;

        if (node.isLeaf) {
            [parentNode removeChildNode:node];
        }
        else if (node.hasAnyChild) {
            [parentNode replaceChildNode:node withNode:node.childNode];
        }
        else {
            BSTNode *minimum = node.rightNode.minimumNode;

            minimum.leftNode = node.leftNode;
            minimum.rightNode = node.rightNode;

            [parentNode replaceChildNode:node withNode:minimum];
        }
    }
}

#pragma mark - Private

- (BSTNode *)minimumNode {
    BSTNode *node = self;

    while (YES) {
        if (!node.leftNode) break;

        node = node.leftNode;
    }

    return node;
}

- (void)removeChildNode:(BSTNode *)node {
    if ([self.leftNode isEqual:node]) {
        self.leftNode = nil;
    }
    else if ([self.rightNode isEqual:node]) {
        self.rightNode = nil;
    }
}

- (void)replaceChildNode:(BSTNode *)node withNode:(BSTNode *)newNode {
    if ([self.leftNode isEqual:node]) {
        self.leftNode = newNode;
    }
    else if ([self.rightNode isEqual:node]) {
        self.rightNode = newNode;
    }
}

- (BSTNode *)childNode {
    if (self.leftNode) return self.leftNode;
    else if (self.rightNode) return self.rightNode;
    else return nil;
}

@end
