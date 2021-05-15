//
//  TeacherViewModel.swift
//  Quickfeed
//

import Foundation
import Combine
import NIO

class TeacherViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol
    @Published var user: User
    @Published var currentCourse: Course
    @Published var enrollments: [Enrollment] = []
    @Published var users: [User] = []
    @Published var groups: [Group] = []
    @Published var assignments: [Assignment] = []
    @Published var manuallyGradedAssignments: [Assignment] = []
    @Published var enrollmentLinks: [EnrollmentLink] = []
    @Published var reviewInProgress: Review? = nil
    
    init(provider: ProviderProtocol, course: Course) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
        self.currentCourse = course
        self.loadAssignments()
        self.loadUsers()
        self.loadGroups()
        self.loadEnrollmentLinks()
        
    }
    
    func loadUsers(){
        for enrollmentLink in self.enrollmentLinks{
            self.users.append(enrollmentLink.enrollment.user)
        }
    }
    
    func loadGroups(){
        let response = self.provider.getGroupsByCourse(courseId: self.currentCourse.id)
        _ = response.always {(response: Result<Groups, Error>) in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self.groups = response.groups
                }
            case .failure(let err):
                print("[Error] Connection error or groups not found: \(err)")
                self.groups = []
            }
        }
    }
    
    func createGroup(group: Group) -> String?{
        var errString: String? = nil
        let response = self.provider.createGroup(group: group)
        _ = response.always {(response: Result<Group, Error>) in
            switch response {
            case .success( _):
                DispatchQueue.main.async {
                    errString = nil
                }
            case .failure(let err):
                print("[Error] Connection error or groups not found: \(err)")
                errString = err.localizedDescription
            }
        }
        return errString
    }
    
    func loadEnrollmentLinks(){
        let response = self.provider.getSubmissionsByCourse(courseId: self.currentCourse.id, type: SubmissionsForCourseRequest.TypeEnum.all)
        _ = response.always {(response: Result<CourseSubmissions, Error>) in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self.enrollmentLinks = response.links
                }
            case .failure(let err):
                print("[Error] Connection error or enrollments not found: \(err)")
                self.enrollmentLinks = []
            }
        }
    }
    
    func loadEnrollments(){
        let response = self.provider.getEnrollmentsByCourse(courseId: self.currentCourse.id, ignoreGroupMembers: nil, enrollmentStatus: nil)
        _ = response.always {(response: Result<Enrollments, Error>) in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self.enrollments = response.enrollments
                }
            case .failure(let err):
                print("[Error] Connection error or enrollments not found: \(err)")
                self.enrollments = []
            }
        }
    }
    
    func loadAssignments(){
        self.assignments =  self.provider.getAssignments(courseID: self.currentCourse.id)
        self.loadManuallyGradedAssignments(courseId: self.currentCourse.id)
    }
    
    func updateAssignments() -> Bool{
        return self.provider.updateAssignments(courseId: self.currentCourse.id)
    }
    
    func updateSubmission(submission: Submission) -> Bool{
        return provider.updateSubmission(courseId: self.currentCourse.id, submisssion: submission)
    }
    
    func loadManuallyGradedAssignments(courseId: UInt64){
        self.manuallyGradedAssignments =  self.assignments.filter{ assignment in
            assignment.skipTests // skipTests -> assignments is manually graded
        }
    }
    
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]{
        return self.provider.getSubmissionsByUser(courseId: courseId, userId: userId)
    }
    
    func getUserName(userId: UInt64) -> String{
        if users.count == 0{
            self.loadUsers()
        }
        for user in self.users{
            if user.id == userId{
                return user.name
            }
        }
        return "None"
    }
    
   
    
    func updateEnrollment(enrollment: Enrollment, status: Enrollment.UserStatus){
        self.provider.updateEnrollment(enrollment: enrollment, status: status)
    }
    
    // MANUAL GRADING
    func createReview(review: Review) -> Review?{
        return self.provider.createReview(courseId: self.currentCourse.id, review: review)
    }
    
    
    func updateReview(review: Review){
        self.provider.updateReview(courseId: self.currentCourse.id, review: review)
    }
    
    func getSubmissionByAssignment(userId: UInt64, assigmentID: UInt64) -> Submission{
        let submissions = provider.getSubmissionsByUser(courseId: self.currentCourse.id, userId: userId)
        return submissions.first(where: {$0.assignmentID == assigmentID})!
    }
    
    func loadCriteria(assignmentId: UInt64) -> [GradingBenchmark]{
        return self.provider.loadCriteria(courseId: currentCourse.id, assignmentId: assignmentId)
    }
    
    func reset() {
        
    }
}
