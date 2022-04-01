//
//  iOSVmTaskTests.swift
//  iOSVmTaskTests
//
//

import XCTest
@testable import iOSVmTask

class iOSVmTaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Check the internet is connected or not
    func testInternetConnectivity() {
        let expectations = expectation(description: "Check Internet")
        XCTAssert(Reachability.isConnectedToNetwork(), "No Internet connection")
        expectations.fulfill()
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    /// Check the api for getting valid data from server
    func testPeopleApiResponse() {
        let expectations = expectation(description: "Valid Api Response")
        APIService.shareInstance.makeApiRequest(endpoint: people) { (peopleData: [PeopleModel]?, _) in
            XCTAssertNotNil(peopleData, "Unable to fetch data from server")
            if let factList = peopleData {
                XCTAssertTrue(factList.count > 0)

            }
            expectations.fulfill()
        }
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testRoomApiResponse() {
        let expectations = expectation(description: "Valid Api Response")
        APIService.shareInstance.makeApiRequest(endpoint: room) { (roomData: [RoomModel]?, _) in
            XCTAssertNotNil(roomData, "Unable to fetch data from server")
            if let roomList = roomData {
                XCTAssertTrue(roomList.count > 0)

            }
            expectations.fulfill()
        }
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    /// Check retryview initialize
    func testFactsViewController() {
        let expectations = expectation(description: "Check Controller")
        let factsVC = PeopleViewController()
        XCTAssertNotNil(factsVC.retryView, "Retry View is nil")
        XCTAssertNotNil(factsVC.noDataLabel, "No data label View is nil")
        XCTAssertNotNil(factsVC.retryButton, "Retry button is nil")
        factsVC.showRetryView(isHidden: false, message: unknownError)
        factsVC.refreshData(refreshControl: factsVC.refreshControl)
        expectations.fulfill()
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testRoomViewController() {
        let expectations = expectation(description: "Check Controller")
        let roomVC = RoomViewController()
        XCTAssertNotNil(roomVC.retryView, "Retry View is nil")
        XCTAssertNotNil(roomVC.noDataLabel, "No data label View is nil")
        XCTAssertNotNil(roomVC.retryButton, "Retry button is nil")
        roomVC.showRetryView(isHidden: false, message: unknownError)
        roomVC.refreshData(refreshControl: roomVC.refreshControl)
        expectations.fulfill()
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    /// Check rootview Controller is initialize or not
    func testRootViewControllerInitialization() {
        if #available(iOS 13, *) {
            let window =  UIApplication.shared.windows.first { $0.isKeyWindow }
            XCTAssert(window?.rootViewController != nil, "Rootviewcontroller is not initialize")
        } else {
            let window =  UIApplication.shared.windows.first { $0.isKeyWindow }
            XCTAssert(window?.rootViewController != nil, "Rootviewcontroller is not initialize")
        }
    }

}
