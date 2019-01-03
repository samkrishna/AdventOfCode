//
//  Day01.swift
//  AOCSwiftTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

import XCTest

class Day01: XCTestCase {

    var numbers: [Int] {
        var _numbers = type(of: self).input.components(separatedBy: "\n").map({ Int($0) ?? 0})
        _numbers.removeLast()
        return _numbers
    }

    static var input: String = {
        let corpusPath = Bundle(for: Day01.self).path(forResource: "day01", ofType: "txt")!
        let _corpus = try! String(contentsOfFile: corpusPath, encoding: String.Encoding.utf8)
        return _corpus
    }()

    func testDay01PartA() {
        let numberSum = numbers.reduce(0, { x, y in
            x + y
        })

        XCTAssertTrue(numberSum == 547)
    }

    func testDay01PartB() {
        var frequency = 0;
        var frequencySet: Set<Int> = Set()
        var shouldContinue = true

        repeat {
            for delta in numbers {
                frequency += delta

                if frequencySet.contains(frequency) {
                    shouldContinue = false
                    break
                }

                frequencySet.insert(frequency)
            }
        } while shouldContinue

        XCTAssertTrue(frequency == 76414)
    }
}
