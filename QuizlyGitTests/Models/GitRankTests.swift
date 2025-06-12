//
//  GitRankTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 11.06.2025.
//


import XCTest
@testable import QuizlyGit

class GitRankTests: XCTestCase {
    func testRankThresholds() {
        XCTAssertEqual(GitRank.newcomer.requiredScore, 0)
        XCTAssertEqual(GitRank.legend.requiredScore, 50000)
    }
    
    func testNextRank() {
        XCTAssertEqual(GitRank.newcomer.nextRank, .contributor)
        XCTAssertNil(GitRank.legend.nextRank)
    }
}
