//
//  UserManager.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 26/01/2021.
//

import Foundation

public class UserManager {
    private var currentUser: User?
    
    func getCurrentUser() -> User?{
        return currentUser ?? nil
    }
}
