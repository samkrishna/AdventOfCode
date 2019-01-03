//
//  Day02.swift
//  AOCSwiftTests
//
//  Created by Sam Krishna on 1/3/19.
//  Copyright © 2019 SectorMobile. All rights reserved.
//

import AOCSwift
import XCTest

class Day02: XCTestCase {

    var puzzleInput: [String] {
        var _input = type(of: self).input.components(separatedBy: "\n")
        _input .removeLast()
        return _input
    }

    static var input: String = {
        let corpusPath = Bundle(for: Day02.self).path(forResource: "day02", ofType: "txt")!
        let _corpus = try! String(contentsOfFile: corpusPath, encoding: String.Encoding.utf8)
        return _corpus
    }()

    func testDay02PartA() {
        var countingDictM = Dictionary<String, NSCountedSet>(minimumCapacity: 0)

        for line in puzzleInput {
            let chars: [String] = try! line.substringsMatched(by: "\\w")
            let charSet: NSCountedSet = NSCountedSet(array: chars)
            countingDictM.updateValue(charSet, forKey: line)
        }

        var countOf2 = 0
        var countOf3 = 0
        let countingDictI: Dictionary<String, NSCountedSet> = countingDictM

        countingDictI.keys.forEach { key in
            let set: NSCountedSet = countingDictI[key]!
            let chars: [String] = set.allObjects as! [String]
            var passedFor2Chars = false
            var passedFor3Chars = false

            chars.forEach({ ch in
                if set.count(for: ch) == 2 && !passedFor2Chars {
                    countOf2 += 1
                    passedFor2Chars = true
                }
                else if set.count(for: ch) == 3 && !passedFor3Chars {
                    countOf3 += 1
                    passedFor3Chars = true
                }
            })
        }

        let result = countOf2 * countOf3
        XCTAssertTrue(result == 8296)
    }

}
