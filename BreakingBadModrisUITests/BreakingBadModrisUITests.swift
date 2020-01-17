//
//  BreakingBadModrisUITests.swift
//  BreakingBadModrisUITests
//
//  Created by Modris Ozols on 17/01/2020.
//  Copyright © 2020 Modris Ozols. All rights reserved.
//

import XCTest

class BreakingBadModrisUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        
    }

    func testRandomQuote() {
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Braking Bad"].buttons["Random Quote"].tap()
        self.waitForElementToAppear(element: app.staticTexts["authorLabel"], timeout: 10)
        XCTAssertTrue(app.staticTexts["authorLabel"].exists)
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["quoteLabel"]/*[[".staticTexts[\"Ooooooh, wire.\"]",".staticTexts[\"quoteLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["quoteLabel"]/*[[".staticTexts[\"Ooooooh, wire.\"]",".staticTexts[\"quoteLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label != "No quotes found")
        XCTAssertTrue(app.navigationBars["Quotes"].buttons["Braking Bad"].exists)
        XCTAssertTrue(app.navigationBars["Quotes"].buttons["shareButton"].isHittable)
    }
    
    func testCharacterQuoteExists(){
        let app = XCUIApplication()
        app.launch()
        
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Walter White"]/*[[".cells.staticTexts[\"Walter White\"]",".staticTexts[\"Walter White\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        self.waitForElementToAppear(element: app.staticTexts["authorLabel"], timeout: 10)
        XCTAssertTrue(app.staticTexts["authorLabel"].exists)
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["quoteLabel"]/*[[".staticTexts[\"Ooooooh, wire.\"]",".staticTexts[\"quoteLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.navigationBars["Quotes"].buttons["Braking Bad"].exists)
        XCTAssertTrue(app.navigationBars["Quotes"].buttons["shareButton"].isHittable)
    
        //

    }
    
    func testCharacterQuoteNotExists(){
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Todd Alquist"]/*[[".cells.staticTexts[\"Todd Alquist\"]",".staticTexts[\"Todd Alquist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        self.waitForElementToAppear(element: app.staticTexts["authorLabel"], timeout: 10)
        XCTAssertTrue(app.staticTexts["authorLabel"].exists)
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["quoteLabel"]/*[[".staticTexts[\"Ooooooh, wire.\"]",".staticTexts[\"quoteLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.navigationBars["Quotes"].buttons["Braking Bad"].exists)
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
}

