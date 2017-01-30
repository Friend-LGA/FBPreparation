//
//  LinkedList.h
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedList : NSObject <NSCopying, NSMutableCopying, NSCoding, NSFastEnumeration>

@property (assign, nonatomic, readonly) NSUInteger count;
@property (nullable, strong, nonatomic, readonly) Node *head;
@property (nullable, strong, nonatomic, readonly) Node *tail;

- (nullable Node *)nodeAtIndex:(NSUInteger)index;
- (void)addNode:(nonnull Node *)node;
- (void)insertNode:(nonnull Node *)node atIndex:(NSUInteger)index;
- (void)removeNodeAtIndex:(NSUInteger)index;
- (void)removeFirstNode;
- (void)removeLastNode;
- (void)removeAllNodes;

// list[0]
- (nullable Node *)objectAtIndexedSubscript:(NSUInteger)index;
// list[0] = newNode;
- (void)setObject:(nullable Node *)obj atIndexedSubscript:(NSUInteger)idx;

//// dictionary[@"key"]
//- (nullable id)objectForKeyedSubscript:(nonnull id)key;
//// dictionary[@"key"] = object;
//- (void)setObject:(nullable id)object forKeyedSubscript:(nonnull id)key;

- (void)enumerateNodesUsingBlock:(void(^ _Nonnull)(Node * _Nonnull node, NSUInteger index, BOOL * _Null_unspecified stop))block;
- (nonnull NSEnumerator *)objectEnumerator;

@end
