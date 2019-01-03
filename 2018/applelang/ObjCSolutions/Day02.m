//
//  Day02.m
//  AOCObjCTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

@import AOCObjC;
#import <XCTest/XCTest.h>

@interface Day02 : XCTestCase
@property (nonatomic, readonly, strong) NSString *puzzleInput;
@end

@implementation Day02

- (NSString *)puzzleInput
{
    static dispatch_once_t onceToken;
    static NSString *_input;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"day02" ofType:@"txt"];
        _input = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    });

    return _input;
}

- (void)testDay02Part1
{
    NSMutableDictionary *countingDictM = [NSMutableDictionary dictionary];

    [self.puzzleInput enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSArray *chars = [line substringsMatchedByRegex:@"\\w"];
        NSCountedSet *charSet = [NSCountedSet setWithArray:chars];
        countingDictM[line] = charSet;
    }];

    __block NSUInteger countOf3 = 0;
    __block NSUInteger countOf2 = 0;
    NSDictionary<NSString *, NSCountedSet *> *countingDictI = [countingDictM copy];

    for (NSString *key in [countingDictI allKeys]) {
        NSCountedSet *set = countingDictI[key];
        NSArray *chars = [set allObjects];
        BOOL passedFor3Chars = NO;
        BOOL passedFor2Chars = NO;

        for (NSString *ch in chars) {
            if ([set countForObject:ch] == 2 && !passedFor2Chars) {
                countOf2++;
                passedFor2Chars = YES;
            }
            else if ([set countForObject:ch] == 3 && !passedFor3Chars) {
                countOf3++;
                passedFor3Chars = YES;
            }
        }
    }

    NSUInteger result = countOf3 * countOf2;
    XCTAssertTrue(result == 8296);
}

- (void)testDay02Part2FINAL
{
    NSMutableDictionary *countingDictM = [NSMutableDictionary dictionary];
    NSMutableArray<NSDictionary *> *candidates = [NSMutableArray array];
    NSCountedSet *keySet = [NSCountedSet set];

    NSUInteger(^ndiff)(NSString *, NSString *) = ^NSUInteger(NSString *s1, NSString *s2) {
        NSArray<NSString *> *s1chars = [s1 substringsMatchedByRegex:@"\\w"];
        NSArray<NSString *> *s2chars = [s2 substringsMatchedByRegex:@"\\w"];
        __block NSUInteger ndiff = 0;

        [s1chars enumerateObjectsUsingBlock:^(NSString * _Nonnull c1, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *c2 = s2chars[idx];
            if (![c1 isEqualToString:c2] && ndiff < 2) {
                ndiff++;
            }

            *stop = (ndiff >= 2);
        }];

        return ndiff;
    };

    [self.puzzleInput enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSUInteger halfLength = line.length / 2;
        NSArray *halves = [line substringsMatchedByRegex:[NSString stringWithFormat:@"(\\w{%lu})", halfLength]];
        NSString *half1 = halves[0];
        NSString *half2 = halves[1];

        if (!countingDictM[half1]) {
            countingDictM[half1] = half2;
        }
        else {
            NSDictionary *dict = @{ half1 : half2 };
            [candidates addObject:dict];
            [keySet addObject:half1];
        }
    }];

    for (NSString *key in keySet) {
        NSLog(@"key: %@ count = %lu", key, [keySet countForObject:key]);
        NSMutableArray *tailArray = [NSMutableArray arrayWithObject:countingDictM[key]];
        __block NSString *potentialWinner;

        [candidates enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([dict.allKeys.firstObject isEqualToString:key]) {
                [tailArray addObject:dict.allValues.firstObject];
            }
        }];

        for (NSUInteger i = 0; i < tailArray.count; i++) {
            NSString *tail = tailArray[i];
            NSArray<NSString *> *filteredTails = [tailArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString * _Nullable evaluatedTail, NSDictionary<NSString *,id> * _Nullable bindings) {
                return (![tail isEqualToString:evaluatedTail]);
            }]];

            [filteredTails enumerateObjectsUsingBlock:^(NSString * _Nonnull tailTarget, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger deltaCount = ndiff(tail, tailTarget);

                if (deltaCount == 1) {
                    *stop = YES;
                    potentialWinner = tailTarget;
                }
            }];

            if (potentialWinner) {
                break;
            }
        }

        if (potentialWinner) {
            break;
        }
    }

    NSCountedSet *valuesSet = [NSCountedSet set];

    for (NSString *value in countingDictM.allValues) {
        [valuesSet addObject:value];
    }

    NSMutableArray *multipleValueCountArray = [NSMutableArray array];

    for (NSString *value in valuesSet) {
        if ([valuesSet countForObject:value] > 1) {
            [multipleValueCountArray addObject:value];
        }
    }

    NSString *s1;
    NSString *s2;

    for (NSString *value in multipleValueCountArray) {
        NSArray *keys = [countingDictM allKeysForObject:value];
        NSUInteger deltaCount = 0;

        for (NSString *key in keys) {
            NSMutableArray *keysM = [keys mutableCopy];
            [keysM removeObject:key];
            NSArray *editedKeys = [keysM copy];

            for (NSUInteger i = 0; i < editedKeys.count; i++) {
                deltaCount = ndiff(key, editedKeys[i]);

                if (deltaCount == 1) {
                    NSLog(@"We have a single delta b/t the following strings:");
                    s1 = [NSString stringWithFormat:@"%@%@", key, value];
                    s2 = [NSString stringWithFormat:@"%@%@", editedKeys[i], value];
                    break;
                }
            }

            if (deltaCount == 1) {
                break;
            }
        }

        if (deltaCount == 1) {
            break;
        }
    }

    XCTAssertTrue([s1 isEqualToString:@"pazvmqbfjtrbeosiecxlghkwud"]);
    XCTAssertTrue([s2 isEqualToString:@"pazvmqbfotrbeosiecxlghkwud"]);
}

@end
