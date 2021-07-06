//
//  ProviderProtocol.swift
//  Quickfeed
//

import Foundation
import Combine
import NIO


protocol ProviderProtocol{

   

    // MARK: Users
    func setUser(sessionId: String)
    func getUser() -> User?
    func getUsers() -> [User]?
    func updateUser(user: User)
    func isAuthorizedTeacher() -> Bool
    
    // MARK: Groups
    func getGroup(groupID: UInt64) -> Group?
    func getGroupByUserAndCourse(courseID: UInt64, groupID: UInt64?, userID: UInt64) -> Group?
    func getGroupsByCourse(courseID: UInt64) -> EventLoopFuture<Groups>
    func createGroup(group: Group) -> EventLoopFuture<Group>
    func updateGroup(group: Group)
    func deleteGroup(userID: UInt64, groupID: UInt64, courseID: UInt64)
    
    // MARK: Courses
    func getCourse(courseID: UInt64) -> Course?
    func getCourses() -> [Course]?
    func getCoursesByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]?
    func createCourse(course: Course) -> Course?
    func updateCourse(course: Course)
    func updateCourseVisibility(enrollment: Enrollment)
    
    // MARK: Assignments
    func getAssignments(courseID: UInt64) -> [Assignment]?
    func updateAssignments(courseID: UInt64) -> Bool
    
    // MARK: Enrollments
    func getEnrollmentsByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Enrollment]?
    func getEnrollmentsByCourse(courseID: UInt64, ignoreGroupMembers: Bool?, withActivity: Bool?, userStatus: [Enrollment.UserStatus]) -> EventLoopFuture<Enrollments>
    func createEnrollment(enrollment: Enrollment)
    func updateEnrollment(enrollment: Enrollment)
    func updateEnrollments(courseID: UInt64)
    
    // MARK: Submissions
    func getSubmissions(userID: UInt64?, groupID: UInt64?, courseID: UInt64) -> [Submission]?
    func getSubmissionsByCourse(courseID: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions>
    func updateSubmission(courseID: UInt64, submisssion: Submission) -> Bool
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool)
    func rebuildSubmission(submissionID: UInt64, assignmentID: UInt64) -> Bool
    
    // MARK: Manual Grading
    func createBenchmark(gradingBenchmark: GradingBenchmark) -> GradingBenchmark?
    func updateBenchmark(gradingBenchmark: GradingBenchmark)
    func deleteBenchmark(gradingBenchmark: GradingBenchmark)
    func createCriterion(gradingCriterion: GradingCriterion) -> GradingCriterion?
    func updateCriterion(gradingCriterion: GradingCriterion)
    func deleteCriterion(gradingCriterion: GradingCriterion)
    func createReview(courseID: UInt64, review: Review) -> Review?
    func updateReview(courseID: UInt64, review: Review)
    func getReviewers(submissionID: UInt64, courseID: UInt64) -> Reviewers?
    func loadCriteria(courseID: UInt64, assignmentID: UInt64) -> [GradingBenchmark]
    
    // MARK: Misc
    func getProviders() -> [String]?
    func getOrganization(orgName: String) -> EventLoopFuture<Organization>
    func getRepositories(courseID: UInt64, repositoryTypes: [Repository.TypeEnum]) -> Repositories?
    func isEmptyRepo(userID: UInt64, groupID: UInt64, courseID: UInt64)
}
