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
    var courses: [Course]
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.courses = provider.getCoursesForCurrentUser() ?? []
        assert(provider.isAuthorizedTeacher())
    }
    
    func getCourse(courseId: UInt64) -> Course{
        for course in self.courses{
            if course.id == courseId{
                return course
            }
        }
        return Course()
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment]{
        return provider.getAssignments(courseID: courseID)
    }
    
    func reset() {
        
    }
    
}
