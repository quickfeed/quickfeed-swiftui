//
//  ProviderProtocol.swift
//  Quickfeed
//

import Foundation
import Combine
import NIO


protocol ProviderProtocol{
    func setUser(userID: UInt64)
    func getUser() -> User?
    func getCoursesForCurrentUser() -> [Course]?
    func isAuthorizedTeacher() -> Bool
    func getCourses() -> [Course]?
    func getUsers() -> [User]?
    func updateUser(user: User)
    
    
    func getCourse(courseId: UInt64) -> Course?
    func changeName(newName: String)
    func getCoursesStudent() -> [Course]
    
    
    func getAssignments(courseID: UInt64) -> [Assignment]
    func getUsersForCourse(course: Course) -> [User]
    func addUserToCourse(course: Course, user: User) -> Bool
    func changeUserStatus(enrollment: Enrollment, status: Enrollment.UserStatus) -> Status
    func approveAll(courseId: UInt64) -> Bool
    func createNewCourse(course: Course) -> Course
    func updateCourse(course: Course)
    func updateCourseVisibility(enrollment: Enrollment) -> Bool
    func getGroupsForCourse(courseId: UInt64) -> [Group]
    func updateGroupStatus(groupId: UInt64, status: Group.GroupStatus) -> Status
    func createGroup(group: Group) -> EventLoopFuture<Group>
    func getGroup(groupId: UInt64) -> EventLoopFuture<Group>
    func deleteGroup(courseId: UInt64, groupId: UInt64) -> Status
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group?
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups>
    func updateGroup(group: Group) -> Status
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission]
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions>
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment]
    func getOrganization(orgName: String) -> Organization
    func getProviders() -> [String]
    func updateAssignments(courseId: UInt64) -> Bool
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool)
    func rebuildSubmission(assignmentId: UInt64, submissionId: UInt64) -> Submission?
    func getRepositories(courseId: UInt64, types: [Repository.Type])
    func createEnrollment(courseID: UInt64, userID: UInt64)
    func getEnrollmentsByCourse(courseId: UInt64, ignoreGroupMembers: Bool?, enrollmentStatus: [Enrollment.UserStatus]?) -> EventLoopFuture<Enrollments>
    
    func createReview(courseId: UInt64, review: Review) -> Review?
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers?
    func updateReview(courseId: UInt64, review: Review)
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark]
    
}
