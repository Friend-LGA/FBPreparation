//
//  main.m
//  Test
//
//  Created by Grigory Lutkov on 21/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Algorithms.h"
#import "DataStructures.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

//        // Variables, References and Pointers
//
//        int aVar = 0;
//        NSLog(@"aVar = %d, &aVar = %p", aVar, &aVar);
//        int *bVar = &aVar;
//        *bVar = 5;
//        NSLog(@"aVar = %d, &aVar = %p, *bVar = %d, bVar = %p, &bVar = %p", aVar, &aVar, *bVar, bVar, &bVar);
//        int **cVar = &bVar;
//        **cVar = 10;
//        NSLog(@"aVar = %d, &aVar = %p, *bVar = %d, bVar = %p, &bVar = %p, **cVar = %d, *cVar = %p, cVar = %p, &cVar = %p", aVar, &aVar, *bVar, bVar, &bVar, **cVar, *cVar, cVar, &cVar);
//
//        separator;
//
//        NSNumber *aPointer = @0;
//        NSLog(@"aPointer = %@, &aPointer = %p", aPointer, &aPointer);
//        NSNumber * __strong *bPointer = &aPointer;
//        *bPointer = @5;
//        NSLog(@"aPointer = %@, &aPointer = %p, *bPointer = %@, bPointer = %p, &bPointer = %p", aPointer, &aPointer, *bPointer, bPointer, &bPointer);
//        NSNumber * __strong **cPointer = &bPointer;
//        **cPointer = @10;
//        NSLog(@"aPointer = %@, &aPointer = %p, *bPointer = %@, bPointer = %p, &bPointer = %p, **cPointer = %@, *cPointer = %p, cPointer = %p, &cPointer = %p",
//              aPointer, &aPointer, *bPointer, bPointer, &bPointer, **cPointer, *cPointer, cPointer, &cPointer);
//
//        separator;

//        // Sorting algorithms
//
//        [[Algorithms new] run];

        // Data structures

        [[DataStructures new] run];
    }
    return 0;
}
