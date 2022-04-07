//
//  ListViewModel.swift
//  VM Directory
//
//  Created by Prasad on 03/04/22.
//

import Foundation

class ListViewModel {
    let networkManager: NetworkManagerProtocol
    
    var peopleList = [Person]()
    var roomsList = [Room]()
    
    var responseReceived: ((SegmentState)->Void)?
    var showError: ((SegmentState, String)->Void)?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension ListViewModel {
    
    private func getPeopleAPIUrl() -> String {
        API.baseURL.rawValue + ApiName.people.rawValue
    }
    
    private func getRoomsAPIUrl() -> String {
        API.baseURL.rawValue + ApiName.rooms.rawValue
    }
}

extension ListViewModel {
    public func getPeopleList() {
        networkManager.fetchData(requestType: "people",
                                 requestUrl: getPeopleAPIUrl()) { [weak self] (result : Result<[Person],Error>) in
            switch result {
            case .success(let model):
                self?.peopleList = model
                self?.responseReceived?(.people)
            case .failure(let error):
                self?.showError?(.people, error.localizedDescription)
            }
        }
    }
    
    public func getPeopleCount() -> Int {
        peopleList.count
    }
    
    public func getRoomsList() {
        networkManager.fetchData(requestType: "rooms",
                                 requestUrl: getRoomsAPIUrl()) { [weak self] (result : Result<[Room],Error>) in
            switch result {
            case .success(let model):
                self?.roomsList = model
                self?.responseReceived?(.rooms)
            case .failure(let error):
                self?.showError?(.rooms, error.localizedDescription)
            }
        }
    }
    
    public func getRoomsCount() -> Int {
        roomsList.count
    }
}

extension ListViewModel {
    public func getPersonName(at index:Int) -> String {
        let person = peopleList[index]
        return person.getName()
    }
    
    public func getJobTitle(at index:Int) -> String {
        let person = peopleList[index]
        return person.getJobTitle()
    }
    
    public func getPerson(at index:Int) -> Person {
        peopleList[index]
    }
}

extension ListViewModel {
    public func getRoomOccupancy(at index:Int) -> String {
        let room = roomsList[index]
        return room.getRoomOccupancy()
    }
    
    public func getRoomAvailability(at index:Int) -> String {
        let room = roomsList[index]
        return room.getRoomAvailability()
    }
    
    public func isRoomOccupied(at index:Int) -> Bool {
        let room = roomsList[index]
        return room.isRoomOccupied()
    }
}
