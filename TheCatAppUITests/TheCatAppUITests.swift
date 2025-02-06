//
//  TheCatAppUITests.swift
//  TheCatAppUITests
//
//  Created by Sofia Cantero on 4/02/25.
//

import XCTest

final class TheCatAppUITests: XCTestCase {
    @MainActor
    func testVerifyCatDetailScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let americanCurl = app.staticTexts["American Curl"]
        _ = americanCurl.waitForExistence(timeout: 2)
        americanCurl.tap()
        
        // Wait for detail data loading
        _ = americanCurl.waitForExistence(timeout: 2)
        
        XCTAssert(americanCurl.exists)
        XCTAssert(app.staticTexts["breedCharacteristics"].exists)
        XCTAssert(app.staticTexts["breedDescription"].exists)
    }
}
