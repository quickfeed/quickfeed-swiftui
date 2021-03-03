//
//  ProviderProtocol.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation
import Combine


protocol ProviderProtocol{
    var currentUser: User { get set }
    func getUser() -> User?
    func getAllCoursesForCurrentUser() -> [Course]?
    func getCoursesForCurrentUser() -> [Course]?
    func isAuthorizedTeacher() -> Bool
    func getCourses() -> [Course]
    func getUsers() -> [User]
    
    
    func getCourse(courseId: UInt64) -> Course?
    func changeName(newName: String)
    func getCoursesStudent() -> [Course]
    
    
    func getAssignments(courseID: UInt64) -> [Assignment]
    func getUsersForCourse(course: Course) -> [User]
    func addUserToCourse(course: Course, user: User) -> Bool
    func changeUserStatus(enrollment: Enrollment, status: Enrollment.UserStatus) -> Status
    func approveAll(courseId: UInt64) -> Bool
    func createNewCourse(course: Course) -> Course
    func updateCourse(course: Course) -> Status
    func updateCourseVisibility(enrollment: Enrollment) -> Bool
    func getGroupsForCourse(courseId: UInt64) -> [Group]
    func updateGroupStatus(groupId: UInt64, status: Group.GroupStatus) -> Status
    func createGroup(groupId: UInt64, name: String, usersIds: [UInt64]) -> Status
    func getGroup(groupId: UInt64) -> Group?
    func deleteGroup(courseId: UInt64, groupId: UInt64) -> Status
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group?
    func updateGroup(group: Group) -> Status
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission]
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission]
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> CourseSubmissions
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment]
    func getOrganization(orgName: String) -> Organization
    func getProviders() -> [String]
    func updateAssignments(courseId: UInt64) -> Bool
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool)
    func rebuildSubmission(assignmentId: UInt64, submissionId: UInt64) -> Submission?
    func getRepositories(courseId: UInt64, types: [Repository.Type])
    
    
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] 
}
