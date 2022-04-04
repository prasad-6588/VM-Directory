//
//  DetailsViewModel.swift
//  VM Directory
//
//  Created by Prasad on 04/04/22.
//

import Foundation

class DetailsViewModel {
    
    var person: Person?
    
    public init(person: Person) {
        self.person = person
    }
}

extension DetailsViewModel {
    public func getPersonName() -> String {
        guard let person = person else { return "" }
        return person.getName()
    }
    
    public func getJobTitle() -> String {
        guard let person = person else { return "" }
        return person.getJobTitle()
    }
    
    public func getEmail() -> String {
        guard let person = person else { return "" }
        return person.getEmail()
    }
    
    public func getFavouriteColor() -> String {
        guard let person = person else { return "" }
        return person.getFavouriteColor()
    }
    
    public func getAvatar() -> String {
        guard let person = person else { return "" }
        return person.getAvatar()
    }
}
