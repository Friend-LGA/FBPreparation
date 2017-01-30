//
//  MatrixGraph.m
//  Test
//
//  Created by Grigory Lutkov on 28/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "MatrixGraph.h"
#import "Edge.h"

@interface MatrixGraph ()

@property (strong, nonatomic) NSMutableArray *vertices;
@property (strong, nonatomic) NSMutableArray *adjacencyMatrix;

@end

@implementation MatrixGraph

- (instancetype)init {
    self = [super init];
    if (self) {
        self.adjacencyMatrix = [NSMutableArray new];
    }
    return self;
}

- (NSSet *)edges {
    NSMutableSet *edges = [NSMutableSet new];

    for (NSUInteger row; row < self.adjacencyMatrix.count; row++) {
        for (NSUInteger column; column < [self.adjacencyMatrix[row] count]; column++) {
            NSObject *weight = self.adjacencyMatrix[row][column];

            if ([weight isKindOfClass:[NSNull class]]) continue;

            Edge *edge = [[Edge alloc] initFromVertex:self.adjacencyMatrix[row] toVertex:self.adjacencyMatrix[column]];
            [edges addObject:edge];
        }
    }

    return edges.copy;
}

- (NSSet *)edgesFromVertex:(Vertex *)vertex {
    NSMutableSet *edges = [NSMutableSet new];

    NSUInteger vertexIndex = [self.vertices indexOfObject:vertex];

    for (NSUInteger column; column < [self.adjacencyMatrix[vertexIndex] count]; column++) {
        NSObject *weight = self.adjacencyMatrix[vertexIndex][column];

        if ([weight isKindOfClass:[NSNull class]]) continue;

        Edge *edge = [[Edge alloc] initFromVertex:vertex toVertex:self.adjacencyMatrix[column]];
        [edges addObject:edge];
    }
    
    return edges.copy;
}

- (Vertex *)vertexWithLabel:(NSString *)label {
    for (Vertex *vertex in self.vertices) {
        if ([label isEqualToString:vertex.label]) {
            return vertex;
        }
    }

    return nil;
}

- (Edge *)edgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    for (NSUInteger row; row < self.adjacencyMatrix.count; row++) {
        for (NSUInteger column; column < [self.adjacencyMatrix[row] count]; column++) {
            if (self.adjacencyMatrix[row] != fromVertex || self.adjacencyMatrix[column] != toVertex) continue;

            NSObject *weight = self.adjacencyMatrix[row][column];

            if ([weight isKindOfClass:[NSNull class]]) return nil;

            return [[Edge alloc] initFromVertex:self.adjacencyMatrix[row] toVertex:self.adjacencyMatrix[column]];
        }
    }

    return nil;
}

- (BOOL)hasVertex:(Vertex *)vertex {
    return [self.vertices containsObject:vertex];
}

- (BOOL)hasEdge:(Edge *)edge {
    return [self edgeFromVertex:edge.fromVertex toVertex:edge.toVertex] != nil;
}

- (BOOL)hasEdgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self edgeFromVertex:fromVertex toVertex:toVertex] != nil;
}

- (void)addVertex:(Vertex *)vertex {
    if ([self hasVertex:vertex]) return;

    [self.vertices addObject:vertex];

    for (NSMutableArray *array in self.adjacencyMatrix) {
        [array addObject:[NSNull null]];
    }

    NSMutableArray *newRow = [NSMutableArray arrayWithCapacity:self.adjacencyMatrix.count + 1];

    for (NSUInteger i = 0; i < self.adjacencyMatrix.count + 1; i++) {
        [newRow addObject:[NSNull null]];
    }

    [self.adjacencyMatrix addObject:newRow];
}

- (void)addEdgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    NSAssert([self hasVertex:fromVertex], @"fromVertex is not member of graph");
    NSAssert([self hasVertex:toVertex], @"toVertex is not member of graph");
    NSAssert([self hasEdgeFromVertex:fromVertex toVertex:toVertex], @"edge already added");

    if (![self hasVertex:fromVertex]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"fromVertex is not member of graph"
                               userInfo:nil] raise];
    }

    if (![self hasVertex:toVertex]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"toVertex is not member of graph"
                               userInfo:nil] raise];
    }

    if (![self hasEdgeFromVertex:fromVertex toVertex:toVertex]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"edge already added"
                               userInfo:nil] raise];
    }

    NSUInteger friomVertexIndex = [self.vertices indexOfObject:fromVertex];
    NSUInteger toVertexIndex = [self.vertices indexOfObject:toVertex];

    [self.adjacencyMatrix[friomVertexIndex] replaceObjectAtIndex:toVertexIndex withObject: @0];
}

- (BOOL)hasPathDFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self hasPathDFS:fromVertex toVertex:toVertex visitedVertices:[NSMutableSet new]];
}

- (BOOL)hasPathDFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex visitedVertices:(NSMutableSet *)visitedVertices {
    if ([visitedVertices member:fromVertex]) {
        return NO;
    }

    [visitedVertices addObject:fromVertex];

    NSSet *edges = [self edgesFromVertex:fromVertex];

    for (Edge *edge in edges) {
        if (edge.toVertex == toVertex) {
            return YES;
        }

        if ([self hasPathDFS:edge.toVertex toVertex:toVertex visitedVertices:visitedVertices]) {
            return YES;
        }
    }

    return NO;
}

- (BOOL)hasPathBFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self hasPathBFS:fromVertex toVertex:toVertex visitedVertices:[NSMutableSet new] waitingVertices:[NSMutableArray new]];
}

- (BOOL)hasPathBFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex visitedVertices:(NSMutableSet *)visitedVertices waitingVertices:(NSMutableArray *)waitingVertices {
    if ([visitedVertices member:fromVertex]) {
        return NO;
    }

    [visitedVertices addObject:fromVertex];

    NSSet *edges = [self edgesFromVertex:fromVertex];

    for (Edge *edge in edges) {
        if (edge.toVertex == toVertex) {
            return YES;
        }

        if ([visitedVertices member:edge.toVertex]) {
            continue;
        }

        [waitingVertices addObject:edge.toVertex];
    }

    Vertex *nextVertex = waitingVertices.firstObject;

    if (!nextVertex) {
        return NO;
    }

    [waitingVertices removeObjectAtIndex:0];

    return [self hasPathBFS:nextVertex toVertex:toVertex visitedVertices:visitedVertices waitingVertices:waitingVertices];
}

@end
