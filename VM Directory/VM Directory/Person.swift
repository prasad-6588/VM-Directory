//
//  Person.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

struct Person: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let jobtitle: String
    let email: String
    let avatar: String
    let favouriteColor: String
    let createdAt: String
}

extension Person {
    func getName() -> String {
        self.firstName + " " + self.lastName
    }
    
    public func getJobTitle() -> String {
        Messages.jobTitle.rawValue + self.jobtitle
    }
    
    public func getEmail() -> String {
        self.email
    }
    
    public func getAvatar() -> String {
        self.avatar
    }
    
    public func getFavouriteColor() -> String {
        self.favouriteColor
    }
}
