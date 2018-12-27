//
//  Day01Tests.swift
//  applelangSwiftTests
//
//  Created by Sam Krishna on 12/26/18.
//  Copyright © 2018 SectorMobile. All rights reserved.
//

import XCTest

class Day01Tests: XCTestCase {

    var testCorpus: String {
        return type(of: self).input
    }

    static var input: String = {
        let corpusPath = Bundle(for: Day01Tests.self).path(forResource: "day01", ofType: "txt")!
        let _corpus = try! String(contentsOfFile: corpusPath, encoding: String.Encoding.utf8)
        return _corpus
    }()

    func testDay01Part1() {
        var sum: Int = 0
        testCorpus.enumerateLines { (line, stop) in
            sum += Int(line) ?? 0
        }

        XCTAssertTrue(sum == 547)
    }
}
