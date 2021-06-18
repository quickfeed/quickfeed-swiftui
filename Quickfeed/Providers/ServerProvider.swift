//
//  ServerProvider.swift
//  Quickfeed
//

import Foundation
import NIO

class ServerProvider: ProviderProtocol{

    var grpcManager: GRPCManager = GRPCManager.shared
    static let shared: ServerProvider = ServerProvider()
    
    private init(){
        print("New ServerProvider")
    }
    
    func setUser(userID: UInt64){
        grpcManager.setUser(userID: userID)
    }
    
    func getUser() -> User? {
        return grpcManager.getUser()
    }
    
    func updateUser(user: User) {
        grpcManager.updateUser(user: user)
    }
    
    func getCoursesForCurrentUser() -> [Course]? {
        return grpcManager.getCoursesForCurrentUser()
    }
    
    func getOrganization(orgName: String) -> EventLoopFuture<Organization> {
        return grpcManager.getOrganization(orgName: orgName)
    }
    
    func isAuthorizedTeacher() -> Bool {
        return grpcManager.isAuthorizedTeacher()
    }
    
    func getCourses() -> [Course]? {
        return grpcManager.getCourses()
    }
    
    func getUsers() -> [User]? {
        return grpcManager.getUsers()
    }

    func getCourse(courseId: UInt64) -> Course? {
        return self.grpcManager.getCourse(courseID: courseId)
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment] {
        return self.grpcManager.getAssignments(courseId: courseID)
    }
    func updateAssignments(courseId: UInt64) -> Bool {
        return self.grpcManager.updateAssignments(courseId: courseId)
    }
    
    // ENROLLMENTS
    
    func createEnrollment(courseID: UInt64, userID: UInt64) {
        self.grpcManager.createEnrollment(courseID: courseID, userID: userID)
    }
    
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment] {
        return self.grpcManager.getEnrollmentsByUser(userID: userId)
    }
    
    func updateEnrollment(enrollment: Enrollment, status: Enrollment.UserStatus) {
        var enrollment = enrollment
        enrollment.status = status
        grpcManager.updateEnrollment(enrollment: enrollment)
    }

    func getEnrollmentsByCourse(courseId: UInt64, ignoreGroupMembers: Bool?, enrollmentStatus: [Enrollment.UserStatus]?) -> EventLoopFuture<Enrollments>{
        return self.grpcManager.getEnrollmentsByCourse(courseId: courseId, ignoreGroupMembers: ignoreGroupMembers, enrollmentStatus: enrollmentStatus)
        
    }
    
    // GROUPS
    func createGroup(group: Group) -> EventLoopFuture<Group> {
        return self.grpcManager.createGroup(group: group)
    }
    
    func updateGroup(group: Group) {
        self.grpcManager.updateGroup(group: group)
    }
    
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group? {
        return self.grpcManager.getGroupByUserAndCourse(userID: userId, courseID: courseId)
    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups> {
        return self.grpcManager.getGroupsByCourse(courseId: courseId)
    }
    
    
    // SUBMISSIONS
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission] {
        let submissions = self.grpcManager.getSubmissionsForEnrollment(courseId: courseId, userId: userId)
        return submissions
    }
    
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission] {
        return self.grpcManager.getSubbmissionByGroup(courseID: courseId, groupID: groupId)
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions> {
        return self.grpcManager.getSubmissionsByCourse(courseId: courseId, type: type)
    }
    
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool {
        return self.grpcManager.updateSubmission(courseId: courseId, submission: submisssion)
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        grpcManager.updateSubmissions(assignmentID: assignmentID, courseID: courseID, score: score, release: release, approve: approve)
    }
    
    
    // MANUAL GRADING
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] {
        return self.grpcManager.loadCriteria(courseId: courseId, assignmentId: assignmentId)
    }
    
    func createReview(courseId: UInt64, review: Review) -> Review?{
        return self.grpcManager.createReview(courseId: courseId, review: review)
    }
    
    func updateReview(courseId: UInt64, review: Review){
        return self.grpcManager.updateReview(courseId: courseId, review: review)
    }
    
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers?{
        return self.grpcManager.getReviewers(submissionId: submissionId, courseId: courseId)
    }
    
    // Courses
    func createNewCourse(course: Course) -> Course? {
        return grpcManager.createCourse(course: course)
    }
    
    func updateCourse(course: Course) {
        grpcManager.updateCourse(course: course)
    }
    
    // NOT IMPLEMENTED

    func getProviders() -> [String] {
        fatalError("Not implemented")
    }
    
    func rebuildSubmission(assignmentId: UInt64, submissionId: UInt64) -> Submission? {
        fatalError("Not implemented")
    }
    
    func getRepositories(courseId: UInt64, types: [Repository.Type]) {
        fatalError("Not implemented")
    }
    
}
