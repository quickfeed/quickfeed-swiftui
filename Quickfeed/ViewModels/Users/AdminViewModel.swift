//
//  AdminViewModel.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import Foundation

class AdminViewModel: UserViewModelProtocol {
    var provider: ProviderProtocol
    var user: User
    @Published var users: [User]?
    @Published var courses: [Course]?
    
    init(provider: ProviderProtocol) {
        print("New AdminViewModel")
        self.provider = provider
        self.user = provider.getUser()!
        getUsers()
        getCourses()
    }
    
    func updateUser(user: User){
        var user = user
        user.isAdmin = !user.isAdmin
        provider.updateUser(user: user)
        self.getUsers()
    }
    
    func getUsers(){
        self.users = provider.getUsers()
    }

    func getCourses(){
        self.courses = provider.getCourses()
    }
    
    func reset() {
        
    }
}
