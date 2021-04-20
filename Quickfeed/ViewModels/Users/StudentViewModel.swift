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
    @Published var submissions: [Submission]?
    
    init(provider: ProviderProtocol, course: Course) {
        print("New StudentViewModel")
        self.provider = provider
        self.user = provider.getUser()!
        self.course = course
        self.group = provider.getGroupByUserAndCourse(courseId: course.id, userId: user.id)
    }
    
    func getAssignments(){
        self.assignments = provider.getAssignments(courseID: course.id)
    }
    
    func getSubmission(assignment: Assignment) -> Submission? {
        if self.submissions != nil {
            for element in self.submissions! {
                if element.assignmentID == assignment.id {
                    if assignment.isGroupLab && element.groupID != 0 {
                        return element
                    } else if !assignment.isGroupLab && element.groupID == 0{
                        return element
                    }
                }
            }
        }
        return nil
    }
    
    func getSubmissions(){
        var submissions = provider.getSubmissionsByUser(courseId: course.id, userId: user.id)
        if self.group != nil{
            submissions.append(contentsOf: provider.getSubmissionsByGroub(courseId: course.id, groupId: group!.id))
        }
        self.submissions = submissions
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
    
    func getReview(reviews: [Review]) -> [String]? {
        var feedback: [String] = []
        for review in reviews {
            if review.feedback.count != 0 {
                feedback.append(review.feedback)
            }
        }
        if feedback.count != 0 {
            return feedback
        }
        return nil
    }
    
    /*func getCriteriaStatus() -> [Submission.Status] {
        var criteriaStatus: [Submission.Status] = []
        
        return criteriaStatus
    }*/
    
    func reload() {
        self.getAssignments()
        self.getSubmissions()
        /*self.submissions![0].status = Submission.Status.rejected
        self.submissions![0].score = 40*/
    }
    
    
    func reset() {
        
    }
    
}
