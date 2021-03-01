//
//  StudentViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation


class StudentViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol
    @Published var user: User
    @Published var course: Course
    
    init(provider: ProviderProtocol, course: Course) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.course = course
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment]{
        return provider.getAssignments(courseID: courseID)
    }
    
    func reset() {
        
    }
    
}
