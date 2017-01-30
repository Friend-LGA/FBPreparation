//
//  DataStructures.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "DataStructures.h"
#import "LinkedList.h"
#import "Stack.h"
#import "Queue.h"
#import "BSTNode.h"
#import "RBTNode.h"
#import "AVLTNode.h"

@implementation DataStructures

- (void)run {

    // Linked list

    NSLog(@"Linked list ---------------------------------------------------------------------------------------------");

    LinkedList *linkedList = [LinkedList new];

    for (NSUInteger i = 0; i < 10; i++) {
        Node *node = [[Node alloc] initWithValue:@(i)];
        [linkedList addNode:node];
    }

    NSLog(@"linkedList: %@", linkedList);

    NSLog(@"linkedList[0]: %@", linkedList[0]);

    for (Node *node in linkedList) {
        NSLog(@"linkedList for/in enumerate node: %@", node);
    }

    [linkedList enumerateNodesUsingBlock:^(Node *node, NSUInteger index, BOOL *stop) {
        NSLog(@"linkedList block enumerate node: %@", node);
    }];

    Node *node = [[Node alloc] initWithValue:@"^_^"];
    [linkedList insertNode:node atIndex:5];

    NSLog(@"linkedList: %@", linkedList);

    [linkedList removeLastNode];

    NSLog(@"linkedList: %@", linkedList);

    [linkedList removeFirstNode];

    NSLog(@"linkedList: %@", linkedList);

    [linkedList removeNodeAtIndex:4];

    NSLog(@"linkedList: %@", linkedList);

    [linkedList removeAllNodes];

    NSLog(@"linkedList: %@", linkedList);

    // Stack

    NSLog(@"Stack ---------------------------------------------------------------------------------------------------");

    Stack *stack = [Stack new];

    for (NSUInteger i = 0; i < 10; i++) {
        [stack push:@(i)];
    }

    NSLog(@"stack: %@", stack);
    NSLog(@"stack.top: %@", stack.top);
    NSLog(@"stack.pop: %@, stack: %@", [stack pop], stack);

    // Queue

    NSLog(@"Queue ---------------------------------------------------------------------------------------------------");

    Queue *queue = [Queue new];

    for (NSUInteger i = 0; i < 10; i++) {
        [queue enqueue:@(i)];
    }

    NSLog(@"queue: %@", queue);
    NSLog(@"queue.first: %@", queue.first);
    NSLog(@"queue.last: %@", queue.last);
    NSLog(@"queue.dequeue: %@, queue: %@", [queue dequeue], queue);

    // Binary Search Tree

    NSLog(@"Binary Search Tree --------------------------------------------------------------------------------------");

    NSMutableArray *array = [NSMutableArray arrayWithObjects:@0, @2, @4, @6, @8, @12, @14, @16, @18, nil];

    BSTNode *bstNode = [[BSTNode alloc] initWithValue:@10];

    for (NSInteger i = array.count - 1; i >= 0; i--) {
        NSUInteger index = i > 0 ? arc4random() % i : 0;
        [bstNode addNodeWithValue:array[index]];
        [array removeObjectAtIndex:index];
    }

    NSLog(@"bstree: %@", bstNode.treeNodesDescriptionInOrder);
    NSLog(@"bstree: %@", bstNode.treeValuesDescriptionInOrder);
    NSLog(@"bstree height: %lu", (long unsigned)bstNode.height);
    NSLog(@"bstree: node with value 12: %@", [bstNode nodeWithValue:@12]);
    NSLog(@"bstree: node with value 12 depth: %lu", (long unsigned)[bstNode nodeWithValue:@12].depth);

    [bstNode addNodeWithValue:@1];
    [bstNode addNodeWithValue:@1];
    [bstNode addNodeWithValue:@17];
    [bstNode addNodeWithValue:@17];

    NSLog(@"bstree: %@", bstNode.treeValuesDescriptionInOrder);


    [bstNode removeNodesWithValue:@1];
    [bstNode removeNodesWithValue:@2];
    [bstNode removeNodesWithValue:@16];
    [bstNode removeNodesWithValue:@17];

    NSLog(@"bstree: %@", bstNode.treeValuesDescriptionInOrder);

    // Red-Black Tree

    NSLog(@"Red-Black Tree ------------------------------------------------------------------------------------------");

    RBTNode *rbtNode = [[RBTNode alloc] initWithValue:@0];

    for (NSUInteger i = 2; i < 20; i += 2) {
        [rbtNode addNodeWithValue:@(i)];
    }

    NSLog(@"rbtree: %@", rbtNode.treeValuesDescriptionInOrder);

    // AVL Tree

    NSLog(@"AVL Tree ------------------------------------------------------------------------------------------");

    AVLTNode *avltNode = [[AVLTNode alloc] initWithValue:@0];

    for (NSUInteger i = 2; i < 20; i += 2) {
        [avltNode addNodeWithValue:@(i)];
    }

    NSLog(@"avltree: %@", avltNode.treeValuesDescriptionInOrder);
}

- (NSUInteger)randomInteger {
    return arc4random() % 10;
}

@end
