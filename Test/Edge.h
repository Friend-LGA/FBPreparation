//
//  Edge.h
//  Test
//
//  Created by Grigory Lutkov on 29/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Edge : NSObject

@property (weak, nonatomic) Vertex *fromVertex;
@property (weak, nonatomic) Vertex *toVertex;
@property (assign, nonatomic) NSUInteger weight;

- (instancetype)initFromVertex:(Vertex *)fromVertex toVertex:(Vertex *)toVertex;

@end
