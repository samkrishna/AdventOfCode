//
//  Day01Tests.m
//  applelangTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Day01Tests : XCTestCase

@end

@implementation Day01Tests

- (void)testDay01Part1
{
    NSString *inputFileName = @"day01";
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:inputFileName ofType:@"txt"];
    NSString *inputString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    __block NSInteger sum = 0;

    [inputString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        sum += line.integerValue;
    }];

    NSLog(@"sum = %ld", sum);
}

- (void)testDay01Part2
{
    NSString *inputFileName = @"day01";
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:inputFileName ofType:@"txt"];
    NSString *inputString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSMutableArray *deltasM = [NSMutableArray array];
    __block NSInteger frequency = 0;
    NSCountedSet *frequencySet = [NSCountedSet set];
    __block BOOL keepCounting = YES;
    __block NSNumber *freqNumber = nil;

    [inputString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        [deltasM addObject:@(line.integerValue)];
    }];

    NSArray *deltas = [deltasM copy];

    do {
        [deltas enumerateObjectsUsingBlock:^(NSNumber * _Nonnull delta, NSUInteger idx, BOOL * _Nonnull stop) {
            frequency += delta.integerValue;
            NSNumber *freq = @(frequency);

            if ([frequencySet countForObject:freq] > 0) {
                freqNumber = freq;
                keepCounting = NO;
                *stop = YES;
            }
            else {
                [frequencySet addObject:@(frequency)];
            }
        }];

        if (!keepCounting) {
            break;
        }
    } while (keepCounting);

    NSLog(@"The first doubled frequency is %@", freqNumber);
}

@end
