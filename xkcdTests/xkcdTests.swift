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
            } catch let err {
            print("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
         
            }
        }
    }
    
    func fetchNumber10() throws {
        Task {
            do {
                let comicNumber = try await ComicController.shared.fetchComic(byNumber: 10)
                print("Comic retrieved: \(comicNumber)")
            } catch let err {
                print("error in \(#file) \(#line) \(#function): \(err.localizedDescription)")
         
            }
        }
    }
}
