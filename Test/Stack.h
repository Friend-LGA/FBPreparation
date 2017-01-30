//
//  Stack.h
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property (assign, nonatomic, readonly) NSUInteger count;

- (NSObject *)top;
- (void)push:(NSObject *)object;
- (NSObject *)pop;

@end
