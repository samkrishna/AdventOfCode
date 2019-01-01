//
//  Day01Tests.m
//  applelangTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Day01Tests : XCTestCase
@property (nonatomic, readonly, strong) NSString *inputString;
@end

@implementation Day01Tests

- (NSString *)inputString
{
    static dispatch_once_t onceToken;
    static NSString *_inputString;
    dispatch_once(&onceToken, ^{
        NSString *inputFileName = @"day01";
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:inputFileName ofType:@"txt"];
        _inputString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    });

    return _inputString;
}

- (void)testDay01Part1
{
    __block NSInteger sum = 0;
    [self.inputString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        sum += line.integerValue;
    }];

    XCTAssertTrue(sum == 547);
}

- (void)testDay01Part2
{
    NSMutableArray *deltasM = [NSMutableArray array];
    __block NSInteger frequency = 0;
    NSCountedSet *frequencySet = [NSCountedSet set];
    __block BOOL keepCounting = YES;
    __block NSNumber *freqNumber = nil;

    [self.inputString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
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

    XCTAssertTrue(freqNumber.unsignedIntegerValue == 76414);
}

@end
