//
//  Algorithms.m
//  Test
//
//  Created by Grigory Lutkov on 24/01/17.
//  Copyright © 2017 Grigory Lutkov. All rights reserved.
//

#import "Algorithms.h"

@implementation Algorithms

- (void)run {
    NSArray *array = @[@99, @81.5, @1, @0, @32.3, @(-16), @74, @0, @(-51.7), @11, @(-99), @(-1.1), @0];

    NSLog(@"bubble sort        | [%@] | O(n^2)", [array componentsJoinedByString:@", "]);
    [self bubbleSort:array.mutableCopy];
    separator;

    NSLog(@"insertion sort     | [%@] | O(n^2)", [array componentsJoinedByString:@", "]);
    [self insertionSort:array.mutableCopy];
    separator;

    NSLog(@"selection sort     | [%@] | O(n^2)", [array componentsJoinedByString:@", "]);
    [self selectionSort:array.mutableCopy];
    separator;

    NSLog(@"shell sort         | [%@] | O(n^2)", [array componentsJoinedByString:@", "]);
    [self shellSort:array.mutableCopy];
    separator;

    NSLog(@"merge sort         | [%@] | O(nlogn)", [array componentsJoinedByString:@", "]);
    NSArray *sortedArray = [self mergeSort:array];
    separator;

    NSLog(@"merge inplace sort | [%@] | O(nlogn)", [array componentsJoinedByString:@", "]);
    [self mergeInplaceSort:array.mutableCopy begin:0 end:array.count-1];
    separator;

    NSLog(@"quick sort         | [%@] | O(nlogn)", [array componentsJoinedByString:@", "]);
    [self quickSort:array];
    separator;

    NSLog(@"quick inplace sort | [%@] | O(nlogn)", [array componentsJoinedByString:@", "]);
    [self quickInplaceSort:array.mutableCopy begin:0 end:array.count-1];
    separator;

    // Search algorithm

    NSNumber *searchNumber = @74;

    NSLog(@"linear search      | [%@] | %@ | O(n)", [array componentsJoinedByString:@", "], searchNumber);
    NSLog(@"linear search      | index = %lu", (long unsigned)[self linearSearch:array object:searchNumber]);
    separator;

    NSLog(@"binary search      | [%@] | %@ | O(logn)", [sortedArray componentsJoinedByString:@", "], searchNumber);
    NSLog(@"binary search      | index = %lu", (long unsigned)[self binarySearch:sortedArray object:searchNumber range:NSMakeRange(0, sortedArray.count)]);
    separator;

    NSString *string = @"Some string to search substring inside it";
    NSString *searchString = @"substring";

    NSLog(@"brute force search | %@ | %@", string, searchString);
    NSLog(@"brute force search | index = %lu", (long unsigned)[self bruteForceSearch:string searchString:searchString]);
    separator;
}

#pragma mark - Bubble Sort

- (void)bubbleSort:(NSMutableArray *)array {
    if (array.count < 2) return;

    NSUInteger iteration = 0;
    NSUInteger replaces = 0;

    for (NSUInteger i = array.count; i > 0; i--) {
        for (NSUInteger j = 1; j < i; j++) {
            iteration++;

            if ([array[j] compare:array[j-1]] == NSOrderedAscending) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j-1];

                replaces++;

                NSLog(@"bubble sort        | [%@] | iteration: %2.lu | replaces: %2.lu", [array componentsJoinedByString:@", "], (unsigned long)iteration, (unsigned long)replaces);
            }
        }
    }
}

#pragma mark - Insertion Sort

- (void)insertionSort:(NSMutableArray *)array {
    if (array.count < 2) return;

    NSUInteger iteration = 0;
    NSUInteger replaces = 0;

    for (NSUInteger i = 1; i < array.count; i++) {
        NSInteger j = i;

        while (j > 0 && [array[j] compare:array[j-1]] == NSOrderedAscending) {
            iteration++;

            [array exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            j--;

            replaces++;

            NSLog(@"insertion sort     | [%@] | iteration: %2.lu | replaces: %2.lu", [array componentsJoinedByString:@", "], (unsigned long)iteration, (unsigned long)replaces);
        }
    }
}

#pragma mark - Selection Sort

- (void)selectionSort:(NSMutableArray *)array {
    if (array.count < 2) return;

    NSUInteger iteration = 0;
    NSUInteger replaces = 0;

    for (NSUInteger i = 0; i < array.count; i++) {
        NSUInteger lowest = i;

        for (NSUInteger j = i + 1; j < array.count; j++) {
            iteration++;

            if ([array[j] compare:array[lowest]] == NSOrderedAscending) {
                lowest = j;
            }
        }

        if (lowest != i) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:lowest];

            replaces++;

            NSLog(@"selection sort     | [%@] | iteration: %2.lu | replaces: %2.lu", [array componentsJoinedByString:@", "], (unsigned long)iteration, (unsigned long)replaces);
        }
    }
}

#pragma mark - Shell Sort

- (void)shellSort:(NSMutableArray *)array {
    if (array.count < 2) return;

    NSUInteger iteration = 0;
    NSUInteger replaces = 0;

    NSUInteger gap = array.count / 2;

    while (gap > 0) {
        for (NSUInteger i = 0; i < gap; i++) {
            for (NSUInteger j = i + gap; j < array.count; j += gap) {
                NSUInteger k = j;

                while (k >= gap && [array[k] compare:array[k-gap]] == NSOrderedAscending) {
                    iteration++;

                    [array exchangeObjectAtIndex:k-gap withObjectAtIndex:k];
                    k -= gap;

                    replaces++;

                    NSLog(@"shell sort         | [%@] | iteration: %2.lu | replaces: %2.lu", [array componentsJoinedByString:@", "], (unsigned long)iteration, (unsigned long)replaces);
                }
            }
        }

        gap /= 2;
    }
}

#pragma mark - Merge Sort

- (NSArray *)mergeArray:(NSArray *)array1 withArray:(NSArray *)array2 {
    if (!array1.count) return array2;
    if (!array2.count) return array1;

    NSMutableArray *resultArray = [NSMutableArray new];

    NSUInteger index1 = 0;
    NSUInteger index2 = 0;

    while(index1 < array1.count && index2 < array2.count) {
        NSNumber *number1 = array1[index1];
        NSNumber *number2 = array2[index2];

        if ([number1 compare:number2] == NSOrderedDescending) {
            [resultArray addObject:number2];
            index2++;
        }
        else {
            [resultArray addObject:number1];
            index1++;
        }
    }

    while (index1 < array1.count) {
        [resultArray addObject:array1[index1]];
        index1++;
    }

    while (index2 < array2.count) {
        [resultArray addObject:array2[index2]];
        index2++;
    }

    return resultArray;
}

- (NSArray *)mergeSort:(NSArray *)array {
    NSUInteger size = array.count;

    if (size < 2) return array;

    NSUInteger middle = size / 2;

    NSArray *array1 = [self mergeSort:[array subarrayWithRange:NSMakeRange(0, middle)]];
    NSArray *array2 = [self mergeSort:[array subarrayWithRange:NSMakeRange(middle, size - middle)]];
    NSArray *resultArray = [self mergeArray: array1 withArray:array2];

    NSLog(@"merge sort         | [%@] => [%@] + [%@] = [%@]",
          [array componentsJoinedByString:@", "],
          [array1 componentsJoinedByString:@", "],
          [array2 componentsJoinedByString:@", "],
          [resultArray componentsJoinedByString:@", "]);

    return resultArray;
}

#pragma mark - Merge Inplace Sort

- (void)mergeInplace:(NSMutableArray *)array begin:(NSUInteger)begin pivot:(NSUInteger)pivot end:(NSUInteger)end {
    NSUInteger index1 = begin;
    NSUInteger index2 = pivot + 1;
    NSUInteger insertPoint = begin;

    while(index1 <= pivot && index2 <= end) {
        NSNumber *number1 = array[index1];
        NSNumber *number2 = array[index2];

        if ([number1 compare:number2] == NSOrderedDescending) {
            NSUInteger counter = 0;

            while (counter < index2 - index1) {
                [array exchangeObjectAtIndex:index2-counter withObjectAtIndex:index2-1-counter];
                counter++;
            }

            index1++;
            pivot++;
            index2++;
            insertPoint++;
        }
        else {
            index1++;
            insertPoint++;
        }
    }
}

- (void)mergeInplaceSort:(NSMutableArray *)array begin:(NSUInteger)begin end:(NSUInteger)end {
    if (array.count < 2 || begin >= end) return;

    NSArray *originalArray = array.copy;

    NSUInteger middle = (begin + end) / 2;

    [self mergeInplaceSort:array begin:begin end:middle];
    [self mergeInplaceSort:array begin:middle + 1 end:end];
    [self mergeInplace:array begin:begin pivot:middle end:end];

    NSLog(@"merge inplace sort | [%@] => [%@]",
          [[originalArray subarrayWithRange:NSMakeRange(begin, end - begin + 1)] componentsJoinedByString:@", "],
          [[array subarrayWithRange:NSMakeRange(begin, end - begin + 1)] componentsJoinedByString:@", "]);
}

#pragma mark - Quick Sort

- (NSArray *)quickSort:(NSArray *)array {
    if (array.count < 2) return array;

    NSMutableArray *lower = [NSMutableArray new];
    NSMutableArray *equal = [NSMutableArray new];
    NSMutableArray *greater = [NSMutableArray new];

    NSNumber *pivot = [array objectAtIndex:array.count/2];

    for (NSNumber *number in array) {
        NSComparisonResult comparisonResult = [number compare:pivot];

        switch (comparisonResult) {
            case NSOrderedAscending:
                [lower addObject:number];
                break;
            case NSOrderedSame:
                [equal addObject:number];
                break;
            case NSOrderedDescending:
                [greater addObject:number];
                break;
            default:
                break;
        }
    }

    NSMutableArray *resultArray = [NSMutableArray new];
    [resultArray addObjectsFromArray:[self quickSort:lower]];
    [resultArray addObjectsFromArray:equal];
    [resultArray addObjectsFromArray:[self quickSort:greater]];

    NSLog(@"quick sort         | [%@] => [%@]",
          [array componentsJoinedByString:@", "],
          [resultArray componentsJoinedByString:@", "]);

    return resultArray;
}

#pragma mark - Quick Inplace Sort

- (void)quickInplaceSort:(NSMutableArray *)array begin:(NSUInteger)begin end:(NSUInteger)end {
    if (array.count < 2 || begin >= end) return;

    NSArray *originalArray = array.copy;

    NSUInteger index1 = begin;
    NSUInteger index2 = end;
    NSNumber *pivot = [array objectAtIndex:(begin + end)/2];

    while (YES) {
        while ([array[index1] compare:pivot] == NSOrderedAscending) {
            index1++;
        }

        while ([array[index2] compare:pivot] == NSOrderedDescending) {
            index2--;
        }

        if (index1 >= index2) break;

        [array exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
        index1++;
        index2--;
    }

    [self quickInplaceSort:array begin:begin end:index2];
    [self quickInplaceSort:array begin:index2 + 1 end:end];

    NSLog(@"quick inplace sort | [%@] => [%@]",
          [[originalArray subarrayWithRange:NSMakeRange(begin, end - begin + 1)] componentsJoinedByString:@", "],
          [[array subarrayWithRange:NSMakeRange(begin, end - begin + 1)] componentsJoinedByString:@", "]);
}

#pragma mark - Linear Search

- (NSUInteger)linearSearch:(NSArray *)array object:(NSObject *)object {
    if (!array.count || !object) return NSNotFound;

    for (NSUInteger i = 0; i < array.count; i++) {
        if ([object isEqualTo:array[i]]) {
            return i;
        }
    }

    return NSNotFound;
}

#pragma mark - Binary Search

- (NSUInteger)binarySearch:(NSArray *)array object:(NSNumber *)object range:(NSRange)range {
    NSUInteger size = array.count;

    if (!size || !object || range.location == NSNotFound || !range.length) return NSNotFound;

    NSUInteger middleIndex = range.location + range.length / 2;
    NSNumber *middle = [array objectAtIndex:middleIndex];
    NSComparisonResult comparisonResult = [object compare:middle];

    switch (comparisonResult) {
        case NSOrderedSame:
            return middleIndex;
        case NSOrderedAscending:
            return [self binarySearch:array object:object range:NSMakeRange(0, middleIndex)];
        case NSOrderedDescending:
            return [self binarySearch:array object:object range:NSMakeRange(middleIndex + 1, size - (middleIndex + 1))];
        default:
            return NSNotFound;
    }
}

#pragma mark - Brute Force Search

- (NSUInteger)bruteForceSearch:(NSString *)string searchString:(NSString *)searchString {
    if (!string.length || !searchString) return NSNotFound;

    for (NSUInteger i = 0; i < string.length; i++) {
        unichar character = [string characterAtIndex:i];
        
        if (character == [searchString characterAtIndex:0]) {
            BOOL matches = true;
            
            for (NSUInteger j = 1; j < searchString.length; j++) {
                if (i+j >= string.length || [string characterAtIndex:i+j] != [searchString characterAtIndex:j]) {
                    matches = NO;
                }
            }
            
            if (matches) {
                return i;
            }
        }
    }
    
    return NSNotFound;
}

@end
