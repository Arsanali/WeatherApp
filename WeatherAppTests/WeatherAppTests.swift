//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by arslanali on 06.05.2024.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

	private let service = ServiceProvider()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNetworkWork() async throws {
		do {
			let data = try await service.searchCityService.getCity("Москва")
			XCTAssertNotNil(data.name)
		} catch {
			print("Error")
		}
		
	}
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
