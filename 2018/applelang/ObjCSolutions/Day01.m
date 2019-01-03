//
//  Day01.m
//  AOCObjCTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Day01 : XCTestCase
@property (nonatomic, readonly, strong) NSArray<NSNumber *> *numbers;
@end

@implementation Day01

- (NSArray<NSNumber *> *)numbers
{
    static NSMutableArray *arrayM;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"day01" ofType:@"txt"];
        NSString *inputString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        arrayM = [NSMutableArray array];

        [inputString enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
            [arrayM addObject:@(line.integerValue)];
        }];
    });

    return [arrayM copy];
}

- (void)testDay01PartA
{
    __block NSInteger sum = 0;
    [self.numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull num, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += num.integerValue;
    }];

    XCTAssertTrue(sum == 547);
}

- (void)testDay01PartB
{
    __block NSInteger frequency = 0;
    __block NSNumber *freqNumber = nil;
    NSMutableSet *frequencySet = [NSMutableSet set];

    do {
        for (NSNumber *delta in self.numbers) {
            frequency += delta.integerValue;
            NSNumber *freq = @(frequency);

            if ([frequencySet containsObject:freq]) {
                freqNumber = freq;
                break;
            }

            [frequencySet addObject:freq];
        }
    } while (!freqNumber);

    XCTAssertTrue(freqNumber.unsignedIntegerValue == 76414);
}

@end
