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
    var users: [User]
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.courses = provider.getCoursesForCurrentUser() ?? []
        assert(provider.isAuthorizedTeacher())
        self.users = []
    }
    
    func getCourse(courseId: UInt64) -> Course{
        for course in self.courses{
            if course.id == courseId{
                return course
            }
        }
        return Course()
    }
    
    func getStudentsForCourse(courseId: UInt64) -> [User]{
        let course = provider.getCourse(courseId: courseId)
        let users = provider.getUsersForCourse(course: course ?? Course())
        
        self.users = users
        
        return users
        
    }
    
    func reset() {
        
    }
    
    
}
