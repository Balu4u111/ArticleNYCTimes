//
//  APIClientTests.swift
//  NYCTimesArticleTests
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import XCTest

class APIClientTests: XCTestCase {
    
    let testUrl = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=9AdMgNZjVoMP82lgCGe4CLJHOCfw6bHD"
    var sut: URLSession!
    var allSection: String?
    var timePeriod: Int?
    var apiKey: String?
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
        allSection = "all-sections"
        timePeriod = 7
        apiKey = AppConstants.ApiConstants.kApiKey
    }
    
    override func tearDown() {
        sut = nil
        allSection = nil
        timePeriod = nil
        apiKey = nil
        super.tearDown()
    }
    
    func testApiPath() {
        // Given a section and time period, the API path should always be returned.
        let path = String(format: AppConstants.ApiConstants.kFetchArticlesUri, allSection!, timePeriod!, apiKey!)
        XCTAssertNotNil(path)
    }

    func testAPIURL() {
        let url  = URL(string:String.init(format: AppConstants.ApiConstants.kFetchArticlesUri, allSection!, timePeriod!, apiKey!))
        XCTAssert(url?.absoluteString == testUrl)
    }
    
    func testValidCall() {
        guard let url = URL(string: testUrl) else {
            XCTFail("Invalid URL")
            return
        }
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    func testCallCompletion() {
        
        guard let url = URL(string: testUrl) else {
            XCTFail("Invalid URL")
            return
        }
        
        let promise = expectation(description: "Completion handler called")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testAllSectionAPI() {
        // Create an expectation
        let expectation = self.expectation(description: "All articles downloaded")
        var articlesResponse:[Article]?
        
        ApiClient.getDataFromServer(AppConstants.ApiConstants.kSection, timePeriod: 7){ (success, articles, error)  in
            articlesResponse = articles
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fullfilled, or time out
        // after 10 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(articlesResponse != nil)
    }
}
