//
//  TeacherViewModel.swift
//  Quickfeed
//

import Foundation
import Combine
import NIO

class TeacherViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol = ServerProvider.shared
    
    @Published var user: User = ServerProvider.shared.getUser()!
    
    @Published var users: [User] = []
    @Published var groups: [Group] = []
    
    @Published var course: Course
    @Published var enrollments: [Enrollment] = []
    @Published var enrollmentLinks: [EnrollmentLink] = []
    
    @Published var assignments: [Assignment] = []
    @Published var manuallyGradedAssignments: [Assignment] = []
    @Published var reviewInProgress: Review? = nil
    
    init(course: Course) {
        self.course = course
        self.loadAssignments()
        self.loadUsers()
        self.loadGroups()
        self.loadEnrollmentLinks()
        
    }
    
    // MARK: Users
    func loadUsers(){
        for enrollmentLink in self.enrollmentLinks{
            self.users.append(enrollmentLink.enrollment.user)
        }
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
    
    // MARK: Groups
    func loadGroups(){
        let response = self.provider.getGroupsByCourse(courseID: self.course.id)
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
    
    // MARK: Assignments
    func loadAssignments(){
        self.assignments =  self.provider.getAssignments(courseID: self.course.id)!
        self.loadManuallyGradedAssignments(courseId: self.course.id)
    }
    
    func updateAssignments() -> Bool{
        return self.provider.updateAssignments(courseID: self.course.id)
    }

    // MARK: Enrollments
    func loadEnrollments(){
        let response = self.provider.getEnrollmentsByCourse(courseID: self.course.id, ignoreGroupMembers: nil, withActivity: nil, userStatus: [Enrollment.UserStatus.student, Enrollment.UserStatus.teacher, Enrollment.UserStatus.pending])
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
    
    func loadEnrollmentLinks(){
        let response = self.provider.getSubmissionsByCourse(courseID: self.course.id, type: SubmissionsForCourseRequest.TypeEnum.all)
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
    
    func updateEnrollment(enrollment: Enrollment, status: Enrollment.UserStatus){
        var enrollment = enrollment
        enrollment.status = status
        
        self.provider.updateEnrollment(enrollment: enrollment)
    }

    // MARK: Submissions
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]{
        return self.provider.getSubmissions(userID: userId, groupID: nil, courseID: courseId)!
    }
    
    func getSubmissionByAssignment(userId: UInt64, assigmentID: UInt64) -> Submission{
        let submissions = provider.getSubmissions(userID: userId, groupID: nil, courseID: self.course.id)!
        return submissions.first(where: {$0.assignmentID == assigmentID})!
    }
    
    func updateSubmission(submission: Submission) -> Bool{
        return provider.updateSubmission(courseID: self.course.id, submisssion: submission)
    }
    
    // MARK: Manual Grading
    func loadManuallyGradedAssignments(courseId: UInt64){
        self.manuallyGradedAssignments =  self.assignments.filter{ assignment in
            assignment.skipTests // skipTests -> assignments is manually graded
        }
    }
    
    func loadCriteria(assignmentId: UInt64) -> [GradingBenchmark]{
        return self.provider.loadCriteria(courseID: course.id, assignmentID: assignmentId)
    }
    
    func createReview(review: Review) -> Review?{
        return self.provider.createReview(courseID: self.course.id, review: review)
    }
    
    func updateReview(review: Review){
        self.provider.updateReview(courseID: self.course.id, review: review)
    }

    // MARK: Misc
    func reload() {
        self.loadAssignments()
        self.loadUsers()
        self.loadGroups()
        self.loadEnrollmentLinks()
    }
    
    func reset() {
        
    }
}
