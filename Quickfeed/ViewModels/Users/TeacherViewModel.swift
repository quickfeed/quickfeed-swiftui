//
//  TeacherViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
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
    @Published var gradingBenchmarkForAssignment = [UInt64 : [GradingBenchmark]]()
    @Published var assignmentMap = [UInt64 : Assignment]()
    
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
        for enrollment in self.enrollments{
            self.users.append(enrollment.user)
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
        let start = DispatchTime.now()
        let response = self.provider.getSubmissionsByCourse(courseId: self.currentCourse.id, type: SubmissionsForCourseRequest.TypeEnum.all)
        _ = response.always {(response: Result<CourseSubmissions, Error>) in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self.enrollmentLinks = response.links
                    let end = DispatchTime.now()
                    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                    let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                    print("Elapsed time: \(timeInterval) seconds")
                }
            case .failure(let err):
                print("[Error] Connection error or enrollments not found: \(err)")
                self.enrollmentLinks = []
            }
        }
    }
    
    func loadEnrollments(){
        let response = self.provider.getEnrollmentsByCourse(courseId: self.currentCourse.id)
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
        for assignment in assignments{
            self.assignmentMap[assignment.id] = assignment
        }
    }
    
    func loadManuallyGradedAssignments(courseId: UInt64){
        self.manuallyGradedAssignments =  self.assignments.filter{ assignment in
            assignment.skipTests // skipTests -> assignments is manually graded
        }
    }

    
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]{
        return self.provider.getSubmissionsByUser(courseId: courseId, userId: userId)
    }
    
    func getSubmissionLink(userId: UInt64, submissionId: UInt64) -> SubmissionLink?{
        var subLink: SubmissionLink?
        let submissionsByUser = getSubmissionsByUser(courseId: self.currentCourse.id, userId: userId)
        for enrollmentlink in self.enrollmentLinks{
            if enrollmentlink.enrollment.userID == userId{
                for submissionLink in enrollmentlink.submissions{
                    if submissionLink.hasSubmission{
                        if submissionLink.submission.id == submissionId{
                            subLink = submissionLink
                            subLink?.submission = submissionsByUser.first(where: {$0.id == submissionId})!
                            return subLink
                        }
                    }
                }
            }
        }
        return nil
    }
    
    
    func loadBenchmarks(){
        for assignment in manuallyGradedAssignments {
            self.gradingBenchmarkForAssignment[assignment.id] = self.provider.loadCriteria(courseId: assignment.courseID, assignmentId: assignment.id)
        }
    }

    
    
  
    
    func getUserName(userId: UInt64) -> String{
        for user in self.users{
            if user.id == userId{
                return user.name
            }
        }
        return "None"
    }
    
    func getStudentsForCourse(courseId: UInt64) -> [User]{
        let course = provider.getCourse(courseId: courseId)
        let users = provider.getUsersForCourse(course: course ?? Course())
        
        self.users = users
        
        return users
        
    }
    
    // MANUAL GRADING
    func createReview() -> Review?{
        let review = Review()
        
        return self.provider.createReview(courseId: self.currentCourse.id, review: review)
    }
    
    
    func reset() {
        
    }
    
    
}
