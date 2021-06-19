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
    
    func getCoursesForCurrentUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]? {
        return grpcManager.getCoursesByUser(userID: userID, userStatus: userStatus)
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
        let assignments = self.grpcManager.getAssignments(courseID: courseID)
        if assignments != nil {
            return assignments!
        }
        return []
    }
    func updateAssignments(courseId: UInt64) -> Bool {
        return self.grpcManager.updateAssignments(courseID: courseId)
    }
    
    // ENROLLMENTS
    
    func createEnrollment(courseID: UInt64, userID: UInt64) {
        var enrollment = Enrollment()
        enrollment.courseID = courseID
        enrollment.userID = userID
        
        self.grpcManager.createEnrollment(enrollment: enrollment)
    }
    
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment] {
        return self.grpcManager.getEnrollmentsByUser(userID: userId, userStatus: [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student, Enrollment.UserStatus.pending])!
    }
    
    func updateEnrollment(enrollment: Enrollment, status: Enrollment.UserStatus) {
        var enrollment = enrollment
        enrollment.status = status
        grpcManager.updateEnrollment(enrollment: enrollment)
    }

    func getEnrollmentsByCourse(courseId: UInt64, ignoreGroupMembers: Bool?, withActivity: Bool?, userStatus: [Enrollment.UserStatus]) -> EventLoopFuture<Enrollments>{
        return self.grpcManager.getEnrollmentsByCourse(courseID: courseId, ignoreGroupMembers: ignoreGroupMembers, withActivity: withActivity, userStatus: userStatus)
    }
    
    // GROUPS
    func createGroup(group: Group) -> EventLoopFuture<Group> {
        return self.grpcManager.createGroup(group: group)
    }
    
    func updateGroup(group: Group) {
        self.grpcManager.updateGroup(group: group)
    }
    
    func getGroupByUserAndCourse(courseId: UInt64, groupID: UInt64?, userId: UInt64) -> Group? {
        return self.grpcManager.getGroupByUserAndCourse(userID: userId, groupID: groupID, courseID: courseId)
    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups> {
        return self.grpcManager.getGroupsByCourse(courseID: courseId)
    }
    
    
    // SUBMISSIONS
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission] {
        /*let submissions = self.grpcManager.getSubmissionsForEnrollment(courseId: courseId, userId: userId)
        return submissions*/
        return self.grpcManager.getSubmissions(userID: userId, groupID: nil, courseID: courseId)!
    }
    
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission] {
        return self.grpcManager.getSubmissions(userID: nil, groupID: groupId, courseID: courseId)!
        //return self.grpcManager.getSubbmissionByGroup(courseID: courseId, groupID: groupId)
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions> {
        return self.grpcManager.getSubmissionsByCourse(courseID: courseId, type: type)
    }
    
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool {
        return self.grpcManager.updateSubmission(submissionID: submisssion.id, courseID: courseId, score: submisssion.score, released: submisssion.released, status: submisssion.status)
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        grpcManager.updateSubmissions(courseID: courseID, assignmentID: assignmentID, scoreLimit: score, release: release, approve: approve)
    }
    
    
    // MANUAL GRADING
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] {
        return self.grpcManager.loadCriteria(courseID: courseId, assignmentID: assignmentId)!
    }
    
    func createReview(courseId: UInt64, review: Review) -> Review?{
        return self.grpcManager.createReview(courseID: courseId, review: review)
    }
    
    func updateReview(courseId: UInt64, review: Review){
        return self.grpcManager.updateReview(courseID: courseId, review: review)
    }
    
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers?{
        return self.grpcManager.getReviewers(submissionID: submissionId, courseID: courseId)
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
