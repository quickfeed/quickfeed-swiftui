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
    
    func getAssignments(courseId: UInt64) -> [Assignment]{
        return self.provider.getAssignments(courseID: courseId)
    }
    
    func getManuallyGradedAssignments(courseId: UInt64) -> [Assignment]{
        let allAssignments = self.getAssignments(courseId: courseId)
        return allAssignments.filter{ assignment in
            assignment.skipTests // skipTests -> assignments is manually graded
        }
    }
    
    func getSubmissionByUser(courseId: UInt64, userId: UInt64) -> [Submission]{
        return self.provider.getSubmissionsByUser(courseId: courseId, userId: userId)
    }
    
    
    func getAssignmentById(id: UInt64) -> Assignment{
        for course in self.courses{
            for assignment in course.assignments{
                if assignment.id == id{
                    return assignment
                }
            }
        }
        return Assignment()
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
