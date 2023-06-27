//
//  xkcdTests.swift
//  xkcdTests
//
//  Created by Marco Nissen on 21.06.23.
//

import XCTest
import xkcd

final class xkcdTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func fetchLatestNumber() throws {
        Task {
            do {
                let comicNumber = try await ComicController.shared.fetchLatestComicNumber()
                print("Latest Comic Number: \(comicNumber)")
                XCTAssertTrue(comicNumber>10)
            } catch let err {
                print("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
                XCTFail("fetch latest comic failed")
            }
        }
    }
    
    func fetchNumber10() throws {
        Task {
            do {
                let comic = try await ComicController.shared.fetchComic(byNumber: 10)
                print("Comic retrieved: \(comic)")
                XCTAssertTrue(comic.num == 10)
            } catch let err {
                print("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
                XCTFail("fetch 10th comic failed")
            }
        }
    }
}
