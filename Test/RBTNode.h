//
//  RBTNode.h
//  Test
//
//  Created by Grigory Lutkov on 25/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "BSTNode.h"

typedef NS_ENUM(BOOL, RBTNodeColor) {
    RBTNodeColorRed   = 0,
    RBTNodeColorBlack = 1
};

@interface RBTNode : BSTNode

@property (assign, nonatomic) RBTNodeColor color;

- (BOOL)isRed;
- (BOOL)isBlack;

@end
