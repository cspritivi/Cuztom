//
//  LoginWorkflowTests.swift
//  CuztomUITests
//
//  Created by Pritivi S Chhabria on 8/25/24.
//

import XCTest
import SwiftUI
import Firebase
import FirebaseAuth
@testable import Cuztom


final class LoginWorkflowTests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let signOutButton = app.buttons["sign out button"]
        if signOutButton.exists {
            signOutButton.tap()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let deleteAccountButton = app.buttons["delete account button"]
        if deleteAccountButton.exists {
            deleteAccountButton.tap()
        }
        app = nil
    }
    
    func testSignUp() throws {
        
        let signUpLink = app.buttons["go to sign up"]
        XCTAssert(signUpLink.exists)
        signUpLink.tap()
        
        let signUpButton = app.buttons["sign up button"]
        XCTAssert(signUpButton.exists)
        XCTAssertFalse(signUpButton.isEnabled)
        
        let fields = [
            "name" : "First Last",
            "email": "example@gmail.com"
        ]
        let secureFields = [
            "password": "abcdef",
            "confirm password": "abcdef",
        ]
        
        
        for key in fields.keys {
            let currField = app.textFields[key]
            XCTAssert(currField.exists)
            currField.tap()
            currField.typeText(fields[key]!)
        }
        
        for key in secureFields.keys {
            let currField = app.secureTextFields[key]
            XCTAssert(currField.exists)
            currField.tap()
            currField.typeText(secureFields[key]!)
        }
        
        let pointOnImage = app.images["logo"].coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        pointOnImage.press(forDuration: 0.1)
        //The above code is supposed to dismiss the keyboard, but it doesn't
        //Idea: Make the view scrollable and then programmatically scroll
        
        XCTAssert(signUpButton.isEnabled)
        signUpButton.tap()
        
        //Give the program time to load the next view
        
        let fullname = app.staticTexts["fullname"]
        XCTAssert(fullname.waitForExistence(timeout: 5))
        XCTAssertEqual(fullname.label, fields["name"])
        
        let email = app.staticTexts["email"]
        XCTAssert(email.exists)
        XCTAssertEqual(email.label, fields["email"])
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
