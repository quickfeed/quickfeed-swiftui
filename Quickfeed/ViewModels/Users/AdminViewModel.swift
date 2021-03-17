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
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser()!
        getUsers()
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
    
    
    
    func reset() {
        
    }
}
