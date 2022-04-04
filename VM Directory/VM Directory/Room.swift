//
//  Room.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

struct Room: Decodable {
    let id: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let createdAt: String
}

extension Room {
    public func getRoomOccupancy() -> String {
        return Messages.macOccupancy.rawValue + String(self.maxOccupancy)
    }
    
    public func getRoomAvailability() -> String {
        return self.isOccupied ? Messages.unavailable.rawValue : Messages.available.rawValue
    }
    
    public func isRoomOccupied() -> Bool {
        return self.isOccupied
    }
}
