//
//  AdminViewModel.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import Foundation

class AdminViewModel: UserViewModelProtocol {
    static let shared: AdminViewModel = AdminViewModel()
    var provider: ProviderProtocol
    var user: User
    @Published var users: [User]?
    @Published var courses: [Course]?
    
    private init() {
        print("New AdminViewModel")
        self.provider = ServerProvider.shared
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
