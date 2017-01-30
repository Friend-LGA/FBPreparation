//
//  Queue.h
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

@property (assign, nonatomic, readonly) NSUInteger count;

- (NSObject *)first;
- (NSObject *)last;
- (void)enqueue:(NSObject *)object;
- (NSObject *)dequeue;

@end
