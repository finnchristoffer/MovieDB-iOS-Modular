//
//  MovieDB_ModularUITests.swift
//  MovieDB ModularUITests
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import XCTest

final class MovieDB_ModularUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

  func testPerformanceExample() throws {
      // This is an example of a performance test case.
      measure {
          // Put the code you want to measure the time of here.
      }
  }
}
