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
    @Published var enrollments: [Enrollment]?
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser()!
        self.courses = provider.getAllCoursesForCurrentUser() ?? []
    }
    
    func updateUser(name: String, studentID: String, email: String) {
        self.user.name = name
        self.user.studentID = studentID
        self.user.email = email
        self.provider.updateUser(user: self.user)
        self.user = provider.getUser()!
    }
    
    func getCourse(courseId: UInt64) -> Course{
        for course in self.courses{
            if course.id == courseId{
                return course
            }
        }
        return Course()
    }
    
    func getEnrollments() {
        self.enrollments = self.provider.getEnrollmentsForUser(userId: self.user.id)
    }
    
    func reset() {
        
    }
}
