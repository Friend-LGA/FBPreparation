//
//  Node.h
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nullable, copy, nonatomic) NSObject *value;
@property (nullable, strong, nonatomic) Node *childNode;
@property (nullable, weak, nonatomic) Node *parentNode;

- (nonnull instancetype)initWithValue:(nullable NSObject *)value;

@end
