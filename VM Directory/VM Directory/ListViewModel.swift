//
//  ListViewModel.swift
//  VM Directory
//
//  Created by Prasad on 03/04/22.
//

import Foundation

protocol ListResponseDelegate {
    func receivedResponse(for segmentType: SegmentState)
    func receivedRequestError(for segmentType: SegmentState,
                              errorMessage: String)
}

class ListViewModel {
    var viewModelDelegate: ListResponseDelegate?
    var peopleList = [Person]()
    var roomsList = [Room]()
    
    public init(viewModelDelegate: ListResponseDelegate) {
        self.viewModelDelegate = viewModelDelegate
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
        let networkManager = NetworkManager(requestUrl: getPeopleAPIUrl())
        networkManager.fetchData() { (result : Result<[Person],Error>) in
            switch result {
            case .success(let model):
                self.peopleList = model
                self.viewModelDelegate?.receivedResponse(for: .people)
            case .failure(let error):
                self.viewModelDelegate?.receivedRequestError(for: .people,
                                                                errorMessage: error.localizedDescription)
            }
        }
    }
    
    public func getPeopleCount() -> Int {
        peopleList.count
    }
    
    public func getRoomsList() {
        let networkManager = NetworkManager(requestUrl: getRoomsAPIUrl())
        networkManager.fetchData() { (result : Result<[Room],Error>) in
            switch result {
            case .success(let model):
                self.roomsList = model
                self.viewModelDelegate?.receivedResponse(for: .rooms)
            case .failure(let error):
                self.viewModelDelegate?.receivedRequestError(for: .rooms,
                                                                errorMessage: error.localizedDescription)
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
