//
//  ListGraph.h
//  Test
//
//  Created by Grigory Lutkov on 28/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface ListGraph : NSObject

- (void)addVertex:(Vertex *)vertex;
- (void)addEdgeFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex;

- (BOOL)hasPathDFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex;
- (BOOL)hasPathBFS:(Vertex *)fromVertex toVertex:(Vertex *)toVertex;

@end
