//
//  VM_DirectoryUnitTests.swift
//  VM DirectoryUnitTests
//
//  Created by Prasad on 06/04/22.
//

import XCTest
@testable import VM_Directory

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = ListViewModel(networkManager: mockNetworkManager)
    }
    
    func testViewModelPeopleAPICall() {
        sut.getPeopleList()
        XCTAssertTrue(mockNetworkManager.isApiCalled)
    }
    
    func testPeopleCount() {
        sut.getPeopleList()
        XCTAssertEqual(sut.getPeopleCount(), 5)
    }
    
    func testPersonModel() {
        sut.getPeopleList()
        let person = sut.getPerson(at: 0)
        XCTAssertEqual(person.firstName, "Maggie")
        XCTAssertEqual(person.lastName, "Brekke")
        XCTAssertEqual(person.email, "Crystel.Nicolas61@hotmail.com")
        XCTAssertEqual(person.jobtitle, "Future Functionality Strategist")
        XCTAssertEqual(person.avatar, "https://randomuser.me/api/portraits/women/21.jpg")
    }
    
    func testViewModelRoomsAPICall() {
        sut.getRoomsList()
        XCTAssertTrue(mockNetworkManager.isApiCalled)
    }
    
    func testRoomsCount() {
        sut.getRoomsList()
        XCTAssertEqual(sut.getRoomsCount(), 5)
    }
    
    func testRoomModel() {
        sut.getRoomsList()
        
        XCTAssertEqual(sut.getRoomOccupancy(at: 0), "Max Occupancy: 53539")
        XCTAssertEqual(sut.getRoomAvailability(at: 0), "Room Unavailable")
        XCTAssertEqual(sut.isRoomOccupied(at: 0), true)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }

}
