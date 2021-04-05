//
//  Mileage_TrackerTests.swift
//  Mileage TrackerTests
//
//  Created by Alex Luna on 22/07/2020.
//

import XCTest
@testable import Mileage_Tracker

class MileageTrackerTests: XCTestCase {

    func testTracker() throws {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        XCTAssertEqual(tracker.refuels.count, 20, "Tracker doesn't have test Refuels")
        tracker.otherCosts = OtherCost.data
        XCTAssertEqual(tracker.otherCosts.count, 5, "Tracker doesn't have test otherCosts")

        let csv = tracker.generateCSV()
        XCTAssertNotNil(csv, "Tracker generates string to store CSV")

        tracker.deleteData()

        XCTAssertEqual(tracker.refuels.count, 0, "Tracker didn't delete data")

        tracker.loadTestData()

        XCTAssertEqual(tracker.refuels.count, 20, "Tracker didn't load test data")

        tracker.save()

        let file = tracker.csvFile()

        XCTAssertNotNil(file, "Didn't generate CSV URL")
    }

}
