//
//  TeacherViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation
import Combine

class TeacherViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol
    @Published var user: User
    var courses: [Course]
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.courses = provider.getCoursesForCurrentUser() ?? []
        assert(provider.isAuthorizedTeacher())
    }
    
    func reset() {
        
    }
    
    
}
