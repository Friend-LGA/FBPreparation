//
//  Vertex.h
//  Test
//
//  Created by Grigory Lutkov on 28/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertex : NSObject <NSCopying>

@property (copy, nonatomic) NSString *label;

- (instancetype)initWithLabel:(NSString *)label;

@end
