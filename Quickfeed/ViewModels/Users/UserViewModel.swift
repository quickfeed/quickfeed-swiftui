//
//  UserViewModel.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 01/03/2021.
//

import Foundation

class UserViewModel: UserViewModelProtocol {
    var provider: ProviderProtocol
    @Published var user: User
    var courses: [Course]
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.courses = provider.getCoursesForCurrentUser() ?? []
    }
    
    func reset() {
        
    }
}
