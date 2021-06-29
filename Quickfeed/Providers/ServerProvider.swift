//
//  ServerProvider.swift
//  Quickfeed
//

import Foundation
import NIO

class ServerProvider: ProviderProtocol{
    static let shared: ServerProvider = ServerProvider()
    
    var grpcManager: GRPCManager = GRPCManager.shared
    
    private init(){
        print("New ServerProvider")
    }
    
    // MARK: Users
    func setUser(userID: UInt64) {
        grpcManager.setUser(userID: userID)
    }
    
    func getUser() -> User? {
        return grpcManager.getUser()
    }
    
    func getUsers() -> [User]? {
        return grpcManager.getUsers()
    }
    
    func updateUser(user: User) {
        grpcManager.updateUser(user: user)
    }
    
    func isAuthorizedTeacher() -> Bool {
        return grpcManager.isAuthorizedTeacher()
    }
    
    // MARK: Groups
    func getGroup(groupID: UInt64) -> Group? {
        return grpcManager.getGroup(groupID: groupID)
    }
    
    func getGroupByUserAndCourse(courseID: UInt64, groupID: UInt64?, userID: UInt64) -> Group? {
        return self.grpcManager.getGroupByUserAndCourse(userID: userID, groupID: groupID, courseID: courseID)
    }
    
    func getGroupsByCourse(courseID: UInt64) -> EventLoopFuture<Groups> {
        return self.grpcManager.getGroupsByCourse(courseID: courseID)
    }
    
    func createGroup(group: Group) -> EventLoopFuture<Group> {
        return self.grpcManager.createGroup(group: group)
    }
    
    func updateGroup(group: Group) {
        self.grpcManager.updateGroup(group: group)
    }
    
    func deleteGroup(userID: UInt64, groupID: UInt64, courseID: UInt64) {
        grpcManager.deleteGroup(userID: userID, groupID: groupID, courseID: courseID)
    }
    
    // MARK: Courses
    func getCourse(courseID: UInt64) -> Course? {
        return self.grpcManager.getCourse(courseID: courseID)
    }
    
    func getCourses() -> [Course]? {
        return grpcManager.getCourses()
    }
    
    func getCoursesByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]? {
        return grpcManager.getCoursesByUser(userID: userID, userStatus: userStatus)
    }
    
    func createCourse(course: Course) -> Course? {
        return grpcManager.createCourse(course: course)
    }
    
    func updateCourse(course: Course) {
        grpcManager.updateCourse(course: course)
    }
    
    func updateCourseVisibility(enrollment: Enrollment) {
        grpcManager.updateCourseVisibility(enrollment: enrollment)
    }
    
    // MARK: Assignments
    func getAssignments(courseID: UInt64) -> [Assignment]? {
        return grpcManager.getAssignments(courseID: courseID)
    }
    
    func updateAssignments(courseID: UInt64) -> Bool {
        return self.grpcManager.updateAssignments(courseID: courseID)
    }
    
    // MARK: Enrollments
    func getEnrollmentsByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Enrollment]? {
        return grpcManager.getEnrollmentsByUser(userID: userID, userStatus: userStatus)
    }
    
    func getEnrollmentsByCourse(courseID: UInt64, ignoreGroupMembers: Bool?, withActivity: Bool?, userStatus: [Enrollment.UserStatus]) -> EventLoopFuture<Enrollments> {
        return self.grpcManager.getEnrollmentsByCourse(courseID: courseID, ignoreGroupMembers: ignoreGroupMembers, withActivity: withActivity, userStatus: userStatus)
    }
    
    func createEnrollment(enrollment: Enrollment) {
        grpcManager.createEnrollment(enrollment: enrollment)
    }
    
    func updateEnrollment(enrollment: Enrollment) {
        grpcManager.updateEnrollment(enrollment: enrollment)
    }
    
    func updateEnrollments(courseID: UInt64) {
        grpcManager.updateEnrollments(courseID: courseID)
    }
    
    // MARK: Submissions
    func getSubmissions(userID: UInt64?, groupID: UInt64?, courseID: UInt64) -> [Submission]? {
        return grpcManager.getSubmissions(userID: userID, groupID: groupID, courseID: courseID)
    }
    
    func getSubmissionsByCourse(courseID: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions> {
        return self.grpcManager.getSubmissionsByCourse(courseID: courseID, type: type)
    }
    
    func updateSubmission(courseID: UInt64, submisssion: Submission) -> Bool {
        return self.grpcManager.updateSubmission(submissionID: submisssion.id, courseID: courseID, score: submisssion.score, released: submisssion.released, status: submisssion.status)
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        grpcManager.updateSubmissions(courseID: courseID, assignmentID: assignmentID, scoreLimit: score, release: release, approve: approve)
    }
    
    func rebuildSubmission(submissionID: UInt64, assignmentID: UInt64) -> Bool {
        return grpcManager.rebuildSubmission(submissionID: submissionID, assignmentID: assignmentID)
    }
    
    // MARK: Manual Grading
    func createBenchmark(gradingBenchmark: GradingBenchmark) -> GradingBenchmark? {
        return grpcManager.createBenchmark(gradingBenchmark: gradingBenchmark)
    }
    
    func updateBenchmark(gradingBenchmark: GradingBenchmark) {
        grpcManager.updateBenchmark(gradingBenchmark: gradingBenchmark)
    }
    
    func deleteBenchmark(gradingBenchmark: GradingBenchmark) {
        grpcManager.deleteBenchmark(gradingBenchmark: gradingBenchmark)
    }
    
    func createCriterion(gradingCriterion: GradingCriterion) -> GradingCriterion? {
        return grpcManager.createCriterion(gradingCriterion: gradingCriterion)
    }
    
    func updateCriterion(gradingCriterion: GradingCriterion) {
        grpcManager.updateCriterion(gradingCriterion: gradingCriterion)
    }
    
    func deleteCriterion(gradingCriterion: GradingCriterion) {
        grpcManager.deleteCriterion(gradingCriterion: gradingCriterion)
    }
    
    func createReview(courseID: UInt64, review: Review) -> Review?{
        return self.grpcManager.createReview(courseID: courseID, review: review)
    }
    
    func updateReview(courseID: UInt64, review: Review){
        return self.grpcManager.updateReview(courseID: courseID, review: review)
    }
    
    func getReviewers(submissionID: UInt64, courseID: UInt64) -> Reviewers?{
        return self.grpcManager.getReviewers(submissionID: submissionID, courseID: courseID)
    }
    
    func loadCriteria(courseID: UInt64, assignmentID: UInt64) -> [GradingBenchmark] {
        return self.grpcManager.loadCriteria(courseID: courseID, assignmentID: assignmentID)!
    }
    
    // MARK: Misc
    func getProviders() -> [String]? {
        return grpcManager.getProviders()
    }
    
    func getOrganization(orgName: String) -> EventLoopFuture<Organization> {
        return grpcManager.getOrganization(orgName: orgName)
    }
    
    func getRepositories(courseID: UInt64, repositoryTypes: [Repository.TypeEnum]) -> Repositories? {
        return grpcManager.getRepositories(courseID: courseID, repositoryTypes: repositoryTypes)
    }
    
    func isEmptyRepo(userID: UInt64, groupID: UInt64, courseID: UInt64) {
        grpcManager.isEmptyRepo(userID: userID, groupID: groupID, courseID: courseID)
    }
}
