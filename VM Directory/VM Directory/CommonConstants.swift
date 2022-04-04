//
//  CommonConstants.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

import Foundation
import UserNotifications

enum API: String {
    case baseURL = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
}

enum ApiName: String {
    case people = "people"
    case rooms = "rooms"
}

enum Theme: String {
    case primaryBrandColor = "#C40202"
    case primaryTextColor = "#FFFFFF"
}

enum ScreenTitle: String {
    case list = "VM Directory"
    case details = "Details"
}

enum LoaderMessages: String {
    case people = "Fetching People..."
    case rooms = "Fetching Rooms..."
}

enum Messages: String {
    case available = "Room Available"
    case unavailable = "Room Unavailable"
    case jobTitle = "Job Title: "
    case macOccupancy = "Max Occupancy: "
}
