//
//  ListGraph.m
//  Test
//
//  Created by Grigory Lutkov on 28/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "ListGraph.h"
#import "Edge.h"

#pragma mark - EdgeList

@interface EdgeList : NSObject

@property (strong, nonatomic) Vertex *vertex;
@property (strong, nonatomic) NSMutableSet *edges;

@end

@implementation EdgeList

- (instancetype)initFromVerted:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    self = [super init];
    if (self) {
        self.edges = [NSMutableSet new];
    }
    return self;
}

@end

#pragma mark - ListGraph

@interface ListGraph ()

@property (strong, nonatomic) NSMutableSet *adjacencyList;

@end

@implementation ListGraph

- (instancetype)init {
    self = [super init];
    if (self) {
        self.adjacencyList = [NSMutableSet new];
    }
    return self;
}

- (NSSet *)vertices {
    NSMutableSet *vertices = [NSMutableSet new];

    for (EdgeList *list in self.adjacencyList) {
        [vertices addObject:list.vertex];
    }

    return vertices.copy;
}

- (NSSet *)edges {
    NSMutableSet *edges = [NSMutableSet new];

    for (EdgeList *list in self.adjacencyList) {
        [edges unionSet:list.edges];
    }

    return edges.copy;
}

- (Vertex *)vertexWithLabel:(NSString *)label {
    for (EdgeList *list in self.adjacencyList) {
        if ([label isEqualToString:list.vertex.label]) {
            return list.vertex;
        }
    }

    return nil;
}

- (Edge *)edgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    for (EdgeList *list in self.adjacencyList) {
        if (fromVertex != list.vertex) continue;

        for (Edge *edge in list.edges) {
            if (toVertex == edge.toVertex) {
                return edge;
            }
        }
    }

    return nil;
}

- (EdgeList *)edgeListWithVertex:(Vertex *)vertex {
    for (EdgeList *list in self.adjacencyList) {
        if (vertex == list.vertex) {
            return list;
        }
    }

    return nil;
}

#pragma mark - Check

- (BOOL)hasVertex:(Vertex *)vertex {
    for (EdgeList *list in self.adjacencyList) {
        if (vertex == list.vertex) {
            return YES;
        }
    }

    return NO;
}

- (BOOL)hasVertexWithLabel:(NSString *)label {
    return [self vertexWithLabel:label] != nil;
}

- (BOOL)hasEdge:(Edge *)edge {
    return [self edgeFromVertex:edge.fromVertex toVertex:edge.toVertex] != nil;
}

- (BOOL)hasEdgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self edgeFromVertex:fromVertex toVertex:toVertex] != nil;
}

#pragma mark - Actions

- (void)addVertex:(Vertex *)vertex {
    if ([self hasVertex:vertex]) return;

    EdgeList *list = [EdgeList new];
    list.vertex = vertex;
    [self.adjacencyList addObject:list];
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

    Edge *edge = [Edge new];
    edge.fromVertex = fromVertex;
    edge.toVertex = toVertex;

    EdgeList *list = [self edgeListWithVertex:fromVertex];
    [list.edges addObject:edge];
}

#pragma mark - Search

- (BOOL)hasPathDFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self hasPathDFS:fromVertex toVertex:toVertex visitedVertices:[NSMutableSet new]];
}

- (BOOL)hasPathDFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex visitedVertices:(NSMutableSet *)visitedVertices {
    if ([visitedVertices member:fromVertex]) {
        return NO;
    }

    [visitedVertices addObject:fromVertex];

    EdgeList *list = [self edgeListWithVertex:fromVertex];

    for (Edge *edge in list.edges) {
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

    EdgeList *list = [self edgeListWithVertex:fromVertex];

    for (Edge *edge in list.edges) {
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

- (NSArray *)shortestPathBFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    NSMutableDictionary *pathsMap = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSMutableArray new], fromVertex, nil];

    return [self shortestPathBFS:fromVertex
                        toVertex:toVertex
                        pathsMap:pathsMap
                 visitedVertices:[NSMutableSet new]
                 waitingVertices:[NSMutableArray new]];
}

- (NSArray *)shortestPathBFS:(Vertex *)fromVertex
                    toVertex:(Vertex *)toVertex
                    pathsMap:(NSMutableDictionary *)pathsMap
             visitedVertices:(NSMutableSet *)visitedVertices
             waitingVertices:(NSMutableArray *)waitingVertices {
    if ([visitedVertices member:fromVertex]) {
        return nil;
    }

    [visitedVertices addObject:fromVertex];

    // -----

    NSMutableArray *path = [pathsMap[fromVertex] mutableCopy];
    [path addObject:toVertex];
    pathsMap[toVertex] = path;

    // -----

    EdgeList *list = [self edgeListWithVertex:fromVertex];

    for (Edge *edge in list.edges) {
        if (edge.toVertex == toVertex) {
            return path.copy;
        }

        if ([visitedVertices member:edge.toVertex]) {
            continue;
        }

        [waitingVertices addObject:edge.toVertex];
    }

    Vertex *nextVertex = waitingVertices.firstObject;

    if (!nextVertex) {
        return nil;
    }

    [waitingVertices removeObjectAtIndex:0];

    return [self shortestPathBFS:nextVertex toVertex:toVertex pathsMap:pathsMap visitedVertices:visitedVertices waitingVertices:waitingVertices];
}

- (NSArray *)shortestPathDijkstra:(Vertex *)fromVertex toVertex:(Vertex *)toVertex {
    return [self shortestPathsDijkstra:fromVertex][toVertex];
}

- (NSDictionary *)shortestPathsDijkstra:(Vertex *)fromVertex {
    NSMutableSet *foundVertices = [NSMutableSet setWithObjects:fromVertex, nil];
    NSMutableDictionary *distancesMap = [NSMutableDictionary dictionaryWithObjectsAndKeys:@0, fromVertex, nil];
    NSMutableDictionary *parentsMap = [NSMutableDictionary new];

    [self shortestPathsDijkstra:fromVertex
                  foundVertices:foundVertices
                waitingVertices:[NSMutableArray new]
                   distancesMap:distancesMap
                     parentsMap:parentsMap];

    NSMutableDictionary *paths = [NSMutableDictionary new];

    for (Vertex *vertex in distancesMap) {
        paths[vertex] = [NSMutableArray new];

        Vertex *parent = parentsMap[vertex];

        while (parent) {
            [paths[vertex] addObject:parent];

            parent = parentsMap[parent];
        }
    }

    return paths;
}

- (void)shortestPathsDijkstra:(Vertex *)fromVertex
                foundVertices:(NSMutableSet *)foundVertices
              waitingVertices:(NSMutableArray *)waitingVertices
                 distancesMap:(NSMutableDictionary *)distancesMap
                   parentsMap:(NSMutableDictionary *)parentsMap {
    EdgeList *list = [self edgeListWithVertex:fromVertex];
    NSMutableSet *handledVertices = [NSMutableSet new];

    for (Edge *edge in list.edges) {
        if ([foundVertices member:edge.toVertex]) {
            continue;
        }

        if (!distancesMap[edge.toVertex] ||
            (edge.weight + [distancesMap[edge.fromVertex] integerValue]) < [distancesMap[edge.toVertex] integerValue]) {
            distancesMap[edge.toVertex] = @(edge.weight + [distancesMap[edge.fromVertex] integerValue]);
            parentsMap[edge.toVertex] = fromVertex;

            [handledVertices addObject:edge.toVertex];
        }
    }

    if (!handledVertices.count) {
        if (!waitingVertices.count) return;

        Vertex *nextVertex = waitingVertices.firstObject;

        if (!nextVertex) return;

        [waitingVertices removeObjectAtIndex:0];

        [self shortestPathsDijkstra:nextVertex
                      foundVertices:foundVertices
                    waitingVertices:waitingVertices
                       distancesMap:distancesMap
                         parentsMap:parentsMap];

        return;
    }

    // -----

    Vertex *smallestVertex = handledVertices.anyObject;

    for (Vertex *vertex in handledVertices) {
        if ([distancesMap[vertex] integerValue] < [distancesMap[smallestVertex] integerValue]) {
            smallestVertex = vertex;
        }
    }

    [foundVertices addObject:smallestVertex];

    return [self shortestPathsDijkstra:smallestVertex
                         foundVertices:foundVertices
                       waitingVertices:waitingVertices
                          distancesMap:distancesMap
                            parentsMap:parentsMap];
}

@end



















