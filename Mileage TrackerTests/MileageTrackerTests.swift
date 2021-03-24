//
//  Mileage_TrackerTests.swift
//  Mileage TrackerTests
//
//  Created by Alex Luna on 22/07/2020.
//

import XCTest
@testable import Mileage_Tracker

class MileageTrackerTests: XCTestCase {

    func testCSV() throws {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        XCTAssertEqual(tracker.refuels.count, 20)
        tracker.otherCosts = OtherCost.data
        XCTAssertEqual(tracker.otherCosts.count, 5)
    }

}
