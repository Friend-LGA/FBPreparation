//
//  LinkedList.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedListEnumerator : NSEnumerator

@property LinkedList *linkedList;
@property NSUInteger index;

- (instancetype)initWithLinkedList:(LinkedList *)linkedList;

@end

@implementation LinkedListEnumerator

- (instancetype)initWithLinkedList:(LinkedList *)linkedList {
    self = [super init];
    if (self) {
        self.linkedList = linkedList;
        self.index = 0;
    }
    return self;
}

- (Node *)nextObject {
    if (self.index >= self.linkedList.count) return nil;

    Node *node = self.linkedList[self.index];

    self.index++;

    return node;
}

@end

@interface LinkedList ()

@property (readwrite) NSUInteger count;
@property (readwrite) Node *head;
@property (readwrite) Node *tail;

@end

@implementation LinkedList

#pragma mark - NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone {
    LinkedList *linkedList = [[LinkedList allocWithZone:zone] init];

    linkedList.head = self.head.copy;
    linkedList.tail = self.tail.copy;
    linkedList.count = self.count;

    return linkedList;
}

#pragma mark - NSMutableCopying Protocol

- (id)mutableCopyWithZone:(NSZone *)zone {
    LinkedList *linkedList = [[LinkedList allocWithZone:zone] init]; // mutable version

    linkedList.head = self.head.copy;
    linkedList.tail = self.tail.copy;
    linkedList.count = self.count;

    return linkedList;
}

#pragma mark - NSCoding Protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.head forKey:@"head"];
    [aCoder encodeObject:self.tail forKey:@"tail"];
    [aCoder encodeInteger:self.count forKey:@"count"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.head = [aDecoder decodeObjectForKey:@"head"];
        self.tail = [aDecoder decodeObjectForKey:@"tail"];
        self.count = [aDecoder decodeIntegerForKey:@"count"];
    }
    return self;
}

#pragma mark - NSFastEnumeration Protocol

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer
                                    count:(NSUInteger)len {
    NSUInteger count = 0;

    unsigned long countOfItemsAlreadyEnumerated = state->state;

    if (countOfItemsAlreadyEnumerated == 0) {
        state->mutationsPtr = &state->extra[0];
    }

    if (countOfItemsAlreadyEnumerated < self.count) {
        state->itemsPtr = buffer;

        while(countOfItemsAlreadyEnumerated < self.count && count < len) {
            buffer[count] = self[countOfItemsAlreadyEnumerated];
            countOfItemsAlreadyEnumerated++;

            count++;
        }
    }
    else {
        count = 0;
    }

    state->state = countOfItemsAlreadyEnumerated;

    return count;
}

#pragma mark - Cool syntax

- (Node *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self nodeAtIndex:index];
}

- (void)setObject:(nullable Node *)node atIndexedSubscript:(NSUInteger)index {
    Node *prevNode = [self nodeAtIndex:index-1];
    Node *nextNode = [self nodeAtIndex:index+1];

    if (prevNode) {
        prevNode.childNode = node;
    }

    if (nextNode) {
        node.childNode = nextNode;
    }
}

#pragma mark - Enumeration

- (void)enumerateNodesUsingBlock:(void(^)(Node *node, NSUInteger index, BOOL *stop))block {
    BOOL stop = NO;

    for (NSUInteger index = 0; index < self.count; index++) {
        Node *node = self[index];

        block(node, index, &stop);

        if (stop) break;
    }
}

- (NSEnumerator *)objectEnumerator {
    return [[LinkedListEnumerator alloc] initWithLinkedList:self];
}

#pragma mark -

- (Node *)nodeAtIndex:(NSUInteger)index {
    if (self.count < index) return nil;

    NSUInteger counter = 0;
    Node *node = self.head;

    while (counter < index) {
        node = node.childNode;
        counter++;
    }

    return node;
}

- (void)addNode:(Node *)node {
    if (!node) return;

    if (!self.count) {
        self.head = node;
        self.tail = node;
    }
    else {
        self.tail.childNode = node;
        self.tail = node;
    }

    self.count++;
}

- (void)insertNode:(Node *)newNode atIndex:(NSUInteger)index {
    if (!newNode || self.count < index) return;

    Node *node = [self nodeAtIndex:index];
    Node *parentNode = node.parentNode;

    if (parentNode) {
        parentNode.childNode = newNode;
    }

    newNode.childNode = node;
    self.count++;
}

- (void)removeNodeAtIndex:(NSUInteger)index {
    if (self.count < index) return;

    Node *node = [self nodeAtIndex:index];
    Node *childNode = node.childNode;
    Node *parentNode = node.parentNode;

    if (!parentNode) {
        self.head = childNode;
    }

    if (!childNode) {
        self.tail = parentNode;
    }

    parentNode.childNode = childNode;
    self.count--;
}

- (void)removeFirstNode {
    if (!self.count) return;

    self.head = self.head.childNode;
    self.head.parentNode = nil;
    self.count--;
}

- (void)removeLastNode {
    if (!self.count) return;

    self.tail = self.tail.parentNode;
    self.tail.childNode = nil;
    self.count--;
}

- (void)removeAllNodes {
    if (!self.count) return;

    Node *node = self.head;

    while (node) {
        node = node.childNode;
    }

    self.head = nil;
    self.tail = nil;
    self.count = 0;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString new];

    [string appendString:@"("];

    Node *node = self.head;

    while (node) {
        if ([self.head isEqual:node]) {
            [string appendString:@"(Head)"];
        }

        [string appendFormat:@" %@", node];

        if ([self.tail isEqual:node]) {
            [string appendString:@" (Tail)"];
        }

        node = node.childNode;

        if (node) {
            [string appendString:@" <->"];
        }
    }

    [string appendFormat:@") Count: %lu", (long unsigned)self.count];

    return string;
}

@end
