//
//  ServerProvider.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/02/2021.
//
import Foundation
import NIO

class ServerProvider: ProviderProtocol{
    var currentUser: User
    var grpcManager: GRPCManager
  
    init() {
        let userID = UInt64(100)
        self.grpcManager = GRPCManager(userID: userID)
        self.currentUser = self.grpcManager.getUser(userId: userID) ?? User()
    }
    
    func getUser() -> User? {
        return self.currentUser
    }
    
    func updateUser(user: User) {
        grpcManager.updateUser(user: user)
    }
    
    func getAllCoursesForCurrentUser() -> [Course]? {
        var courses: [Course]? = grpcManager.getCourses(userStatus: Enrollment.UserStatus.teacher, userId: currentUser.id)
        courses?.append(contentsOf: grpcManager.getCourses(userStatus: Enrollment.UserStatus.student, userId: currentUser.id))
        return courses
    }
    
    
    func getCoursesForCurrentUser() -> [Course]? {

        return grpcManager.getCourses(userStatus: Enrollment.UserStatus.teacher, userId: self.currentUser.id)

    }
    
    func getEnrollmentsByCourse(courseId: UInt64) -> EventLoopFuture<Enrollments>{
        return self.grpcManager.getEnrollmentsByCourse(courseId: courseId)
        
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
        return self.grpcManager.getCourse(courseId: courseId)
    }
    
    func changeName(newName: String) {
        fatalError("Not implemented")
    }
    
    func getCoursesStudent() -> [Course] {
        fatalError("Not implemented")
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment] {
        return self.grpcManager.getAssignments(courseId: courseID)
    }
    
    func createEnrollment(courseID: UInt64, userID: UInt64) {
        self.grpcManager.createEnrollment(courseID: courseID, userID: userID)
    }
    
    func getEnrollmentsForCourse(course: Course) -> EventLoopFuture<Enrollments> {
        return self.grpcManager.getEnrollmentsByCourse(courseId: course.id)
    }
    
    func addUserToCourse(course: Course, user: User) -> Bool {
        fatalError("Not implemented")
    }
    
    func getUsersForCourse(course: Course) -> [User] {
        fatalError("Not implemented")
    }
    
    
    func changeUserStatus(enrollment: Enrollment, status: Enrollment.UserStatus) -> Status {
        fatalError("Not implemented")
    }
    
    func approveAll(courseId: UInt64) -> Bool {
        fatalError("Not implemented")
    }
    
    func createNewCourse(course: Course) -> Course {
        fatalError("Not implemented")
    }
    
    func updateCourse(course: Course) -> Status {
        fatalError("Not implemented")
    }
    
    func updateCourseVisibility(enrollment: Enrollment) -> Bool {
        fatalError("Not implemented")
    }
    
    func getGroupsForCourse(courseId: UInt64) -> [Group] {
        fatalError("Not implemented")
    }
    
    func updateGroupStatus(groupId: UInt64, status: Group.GroupStatus) -> Status {
        fatalError("Not implemented")
    }
    
    func createGroup(group: Group) -> EventLoopFuture<Group> {
        return self.grpcManager.createGroup(gruop: group)
    }
    
    func getGroup(groupId: UInt64) -> EventLoopFuture<Group> {
        fatalError("Not implemented")
    }
    
    func deleteGroup(courseId: UInt64, groupId: UInt64) -> Status {
        fatalError("Not implemented")
    }
    
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group? {
        return self.grpcManager.getGroupByUserAndCourse(userID: userId, courseID: courseId)
    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups> {
        return self.grpcManager.getGroupsByCourse(courseId: courseId)
    }
    
    func updateGroup(group: Group) -> Status {
        fatalError("Not implemented")
    }
    
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission] {
        let submissions = self.grpcManager.getSubmissionsForEnrollment(courseId: courseId, userId: userId)
        return submissions
    }
    
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission] {
        return self.grpcManager.getSubbmissionByGroup(courseID: courseId, groupID: groupId)
        //fatalError("Not implemented")
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions> {
        return self.grpcManager.getSubmissionsByCourse(courseId: courseId, type: type)
    }
    
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment] {
        return self.grpcManager.getEnrollmentsByUser(userID: userId)
    }
    
    func getOrganization(orgName: String) -> Organization {
        fatalError("Not implemented")
    }
    
    func getProviders() -> [String] {
        fatalError("Not implemented")
    }
    
    func updateAssignments(courseId: UInt64) -> Bool {
        fatalError("Not implemented")
    }
    
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool {
        fatalError("Not implemented")
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        fatalError("Not implemented")
    }
    
    func rebuildSubmission(assignmentId: UInt64, submissionId: UInt64) -> Submission? {
        fatalError("Not implemented")
    }
    
    func getRepositories(courseId: UInt64, types: [Repository.Type]) {
        fatalError("Not implemented")
    }
    
    
    // MANUAL GRADING
    
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] {

        return self.grpcManager.loadCriteria(courseId: courseId, assignmentId: assignmentId)
    }
    
    func createReview(courseId: UInt64, review: Review) -> Review?{
        return self.grpcManager.createReview(courseId: courseId, review: review)
    }
    
    
}
