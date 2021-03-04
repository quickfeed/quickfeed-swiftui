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
    @Published var group: Group?
    @Published var assignments: [Assignment]?
    
    init(provider: ProviderProtocol, course: Course) {
        self.provider = provider
        self.user = provider.getUser()!
        self.course = course
        self.group = provider.getGroupByUserAndCourse(courseId: course.id, userId: user.id)
        self.assignments = provider.getAssignments(courseID: course.id)
    }
    
    func getAssignments() -> [Assignment]{
        return provider.getAssignments(courseID: course.id)
    }
    
    func getSubmission(assignment: Assignment) -> Submission? {
        let submissions = self.getSubmissions()
        for element in submissions {
            if element.assignmentID == assignment.id {
                if assignment.isGroupLab && element.groupID != 0 {
                    return element
                } else if !assignment.isGroupLab && element.groupID == 0{
                    return element
                }
            }
        }
        return nil
    }
    
    func getSubmissions() -> [Submission]{
        var submissions = provider.getSubmissionsByUser(courseId: course.id, userId: user.id)
        if self.group != nil{
            submissions.append(contentsOf: provider.getSubmissionsByGroub(courseId: course.id, groupId: group!.id))
        }
        return submissions
    }
    
    func getSubmissionByGroup() -> [Submission]{
        return provider.getSubmissionsByGroub(courseId: course.id, groupId: group!.id)
    }
    
    func getSlipdays() -> UInt32? {
        let enrollments = provider.getEnrollmentsForUser(userId: user.id)
        for element in enrollments{
            if element.courseID == course.id{
                return element.slipDaysRemaining
            }
        }
        return nil
    }
    
    
    func reset() {
        
    }
    
}
