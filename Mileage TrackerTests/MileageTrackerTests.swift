//
//  Mileage_TrackerTests.swift
//  Mileage TrackerTests
//
//  Created by Alex Luna on 22/07/2020.
//

import XCTest
@testable import Mileage_Tracker

class MileageTrackerTests: XCTestCase {
    let tracker = MileageTracker()

    func testTracker() throws {
        tracker.refuels = Refuel.data
        XCTAssertEqual(tracker.refuels.count, 35, "Tracker didn't load test Refuels")
        tracker.otherCosts = OtherCost.data
        XCTAssertEqual(tracker.otherCosts.count, 5, "Tracker didn't load test otherCosts")
    }
    
    func testGenerateCSV() throws {
        let csv = tracker.generateCSV()
        XCTAssertNotNil(csv, "Tracker generates string to store CSV")
    }
    
    func testTrackerLoadTestData() throws {
        tracker.loadTestData()

        XCTAssertEqual(tracker.refuels.count, 35, "Tracker didn't load test Refuels")
    }
    
    func testDeleteData() throws {
        tracker.loadTestData()
        tracker.deleteData()

        XCTAssertEqual(tracker.refuels.count, 0, "Tracker didn't delete data")
    }
    
    func testTrackerSave() throws {
        tracker.save()

        let file = tracker.csvFile()

        XCTAssertNotNil(file, "Didn't generate CSV URL")
    }
    
    func testCalculateTotalSpending() throws {
        tracker.loadTestData()
        tracker.recalculateStats()
        
        XCTAssertEqual(tracker.totalSpending, 265.13, "Total spending was \(tracker.totalSpending)")
    }
    
    func testCalculateTotalKM() throws {
        tracker.loadTestData()
        tracker.recalculateStats()
        
        XCTAssertEqual(tracker.totalKM, 6215, "Total km was \(tracker.totalKM)")
    }
    
    func testCalculateAverageConsumption() throws {
        tracker.loadTestData()
        tracker.recalculateStats()
        
        XCTAssertEqual(tracker.averageConsumption, 36.5, "Average consumption was \(tracker.averageConsumption)")
    }
        
    func testCalculateAverageSpending() throws {
        tracker.loadTestData()
        tracker.recalculateStats()
        
        XCTAssertEqual(tracker.averageSpending, 23.44, "Average spending was \(tracker.averageSpending)")
    }
    
    func testCalculateAveragePrice() throws {
        tracker.loadTestData()
        tracker.recalculateStats()
        
        XCTAssertEqual(tracker.averagePrice, 1.56, "Average price was \(tracker.averagePrice)")
    }
}
