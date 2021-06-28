//
//  ProviderProtocol.swift
//  Quickfeed
//

import Foundation
import Combine
import NIO


protocol ProviderProtocol{
    // MARK: Users
    func setUser(userID: UInt64)
    func getUser() -> User?
    func getUsers() -> [User]?
    func updateUser(user: User)
    func isAuthorizedTeacher() -> Bool
    
    // MARK: Groups
    func getGroup(groupID: UInt64) -> Group?
    func getGroupByUserAndCourse(courseId: UInt64, groupID: UInt64?, userId: UInt64) -> Group?
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups>
    func createGroup(group: Group) -> EventLoopFuture<Group>
    func updateGroup(group: Group)
    func deleteGroup(userID: UInt64, groupID: UInt64, courseID: UInt64)
    
    // MARK: Courses
    func getCourse(courseId: UInt64) -> Course?
    func getCourses() -> [Course]?
    func getCoursesByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]?
    func createCourse(course: Course) -> Course?
    func updateCourse(course: Course)
    func updateCourseVisibility(enrollment: Enrollment)
    
    // MARK: Assignments
    //func getAssignments(courseID: UInt64) -> [Assignment]?
    func updateAssignments(courseId: UInt64) -> Bool
    
    // MARK: Enrollments
    func getEnrollmentsByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Enrollment]?
    func getEnrollmentsByCourse(courseId: UInt64, ignoreGroupMembers: Bool?, withActivity: Bool?, userStatus: [Enrollment.UserStatus]) -> EventLoopFuture<Enrollments>
    func createEnrollment(enrollment: Enrollment)
    func updateEnrollment(enrollment: Enrollment)
    func updateEnrollments(courseID: UInt64)
    
    // MARK: Submissions
    func getSubmissions(userID: UInt64?, groupID: UInt64?, courseID: UInt64) -> [Submission]?
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions>
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool)
    func rebuildSubmission(submissionID: UInt64, assignmentID: UInt64) -> Bool
    
    // MARK: Manual Grading
    
    // MARK: Misc
    func getProviders() -> [String]?
    func getOrganization(orgName: String) -> EventLoopFuture<Organization>
    func getRepositories(courseID: UInt64, repositoryTypes: [Repository.TypeEnum]) -> Repositories?
    func isEmptyRepo(userID: UInt64, groupID: UInt64, courseID: UInt64)
    
    // TODO: clean
    func getCoursesForCurrentUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]?
    func getAssignments(courseID: UInt64) -> [Assignment]
    func createEnrollment(courseID: UInt64, userID: UInt64)
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment]
    func updateEnrollment(enrollment: Enrollment, status: Enrollment.UserStatus)
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission]
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark]
    func createReview(courseId: UInt64, review: Review) -> Review?
    func updateReview(courseId: UInt64, review: Review)
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers?
    func createNewCourse(course: Course) -> Course?
}
