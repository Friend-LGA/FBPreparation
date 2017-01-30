//
//  BSTNode.h
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTNode : NSObject

@property (strong, nonatomic) BSTNode *leftNode;
@property (strong, nonatomic) BSTNode *rightNode;
@property (weak, nonatomic, readonly) BSTNode *parentNode;
@property (copy, nonatomic) NSObject *value;

- (instancetype)initWithValue:(NSObject *)value;
- (instancetype)initWithValue:(NSObject *)value leftNode:(BSTNode *)leftNode rightNode:(BSTNode *)rightNode;

- (NSString *)treeNodesDescriptionInOrder;
- (NSString *)treeValuesDescriptionInOrder;

- (BOOL)isRoot;
- (BOOL)isLeaf;
- (BOOL)hasAnyChild;
- (BOOL)hasBothChildren;

- (BOOL)traverseInOrder:(void(^)(BSTNode *node, BOOL *stop))handler;
- (BOOL)traversePreOrder:(void(^)(BSTNode *node, BOOL *stop))handler;
- (BOOL)traversePostOrder:(void(^)(BSTNode *node, BOOL *stop))handler;

- (NSUInteger)depth;
- (NSUInteger)height;

- (BSTNode *)rootNode;

- (BOOL)containsNodeWithValue:(NSObject *)value;
- (NSSet *)nodesWithValue:(NSObject *)value;
- (BSTNode *)nodeWithValue:(NSObject *)value;

- (NSArray *)allNodesInOrder;
- (NSArray *)allNodesPreOrder;
- (NSArray *)allNodesPostOrder;

- (NSArray *)allValuesInOrder;
- (NSArray *)allValuesPreOrder;
- (NSArray *)allValuesPostOrder;

/** Including self */
- (NSUInteger)count;

- (BSTNode *)addNodeWithValue:(NSObject *)value;
- (void)removeNodesWithValue:(NSObject *)value;

@end
