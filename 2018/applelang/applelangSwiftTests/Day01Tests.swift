//
//  Day01Tests.swift
//  applelangSwiftTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

import XCTest

class Day01Tests: XCTestCase {

    var numbers: [Int] {
        return type(of: self).input.components(separatedBy: "\n").map({ Int($0) ?? 0})
    }

    static var input: String = {
        let corpusPath = Bundle(for: Day01Tests.self).path(forResource: "day01", ofType: "txt")!
        let _corpus = try! String(contentsOfFile: corpusPath, encoding: String.Encoding.utf8)
        return _corpus
    }()

    func testDay01Part1() {
        let numberSum = numbers.reduce(0, { x, y in
            x + y
        })

        XCTAssertTrue(numberSum == 547)
    }
}
