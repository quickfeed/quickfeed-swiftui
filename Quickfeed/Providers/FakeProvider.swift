//
//  FakeProvider.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation
import NIO

class FakeProvider: ProviderProtocol, ObservableObject{
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers? {
        fatalError("not implemented")
    }
    
    func createGroup(group: Group) -> EventLoopFuture<Group> {
        fatalError("not implemented")

    }
    
    func getGroup(groupId: UInt64) -> EventLoopFuture<Group> {
        fatalError("not implemented")

    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups> {
        fatalError("not implemented")
    }
    
    func createEnrollment(courseID: UInt64, userID: UInt64) {
        fatalError("not implemented")
    }
    
    func getEnrollmentsByCourse(courseId: UInt64) -> EventLoopFuture<Enrollments> {
        fatalError("not implemented")
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions> {
        fatalError("Not implemented")
    }
    
    func createReview(courseId: UInt64, review: Review) -> Review? {
        fatalError("Not implemented")
    }
    
    func getEnrollmentsByCourse(courseId: UInt64) -> [Enrollment] {
        fatalError("Not implemented")
    }
    
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] {
        fatalError("notImplemented")
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> CourseSubmissions {
        fatalError("notImplemented")
    }
    
    
    
    @Published var currentUser: User
    var dummyUsers: [User]
    var courses: [Course]
    
    init() {
        self.courses = []
        self.dummyUsers = []
        self.currentUser = User(name: "Current user", id: 1, studentID: "111111", isAdmin: true, email: "test2@testmail.com", enrollments: [], login: "currusr")
        self.initDummyUsers()
        self.initTestCourses()
        self.initTestEnrollments()
    }
    
    
    func getUser() -> User? {
        return currentUser
    }
    
    func updateUser(user: User) {
        fatalError("Not Implemented yet")
    }
    
    func getUsersForCourse(course: Course) -> [User] {
        let enrollments: [Enrollment] = course.enrollments
        var users: [User] = []
        for enrollment in enrollments{
            users.append(enrollment.user)
        }
        return users
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment]{
        let course: Course = self.getCourseById(courseId: courseID) ?? Course()
        return course.assignments
    }
    
    func changeName(newName: String){
        self.currentUser.name = newName
    }
    
    func isAuthorizedTeacher() -> Bool{
        return true
    }
    
    func getAllCoursesForCurrentUser() -> [Course]?{
        fatalError("Not implemented")
    }
    
    func getCoursesForCurrentUser() -> [Course]?{
        var courses: [Course] = []
        for enrollment in currentUser.enrollments{
            if enrollment.hasCourse{
                courses.append(enrollment.course)
            }
        }
        if courses.isEmpty{
            return nil
        }
        return courses
    }
    
    func getUsersForCourse(courseId: UInt64) -> [User]{
        let course: Course! = self.getCourseById(courseId: courseId)
        assert(course != nil)
        
        var users: [User] = []
        for enrollment in course.enrollments{
            users.append(enrollment.user)
        }
        return users
    }
    
    func getCourseById(courseId: UInt64) -> Course?{
        for course in self.courses{
            if course.id == courseId{
                return course
            }
        }
        return nil
    }
    
    func getCourses() -> [Course]? {
        return self.courses
    }
    
    func updateUser(user: User) -> Bool{
        return true
    }
    
    func getUsers() -> [User]? {
        return self.dummyUsers
    }
    
    func getCourse(courseId: UInt64) -> Course? {
        for course in self.courses{
            if course.id == courseId{
                return course
            }
        }
        return nil
    }
    
    func getCoursesStudent() -> [Course] {
        fatalError("Not implemented")
    }
    
    func addUserToCourse(course: Course, user: User) -> Bool {
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
    
    func createGroup(groupId: UInt64, name: String, usersIds: [UInt64]) -> Status {
        fatalError("Not implemented")
    }
    
    func getGroup(groupId: UInt64) -> Group? {
        fatalError("Not implemented")
    }
    
    func deleteGroup(courseId: UInt64, groupId: UInt64) -> Status {
        fatalError("Not implemented")
    }
    
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group? {
        fatalError("Not implemented")
    }
    
    func updateGroup(group: Group) -> Status {
        fatalError("Not implemented")
    }
    
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission] {
        fatalError("Not implemented")
    }
    
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission] {
        fatalError("Not implemented")
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.Type) -> CourseSubmissions {
        fatalError("Not implemented")
    }
    
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment] {
        fatalError("Not implemented")
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

 
}

// Contains methods not present in the protocol, used for testing
extension FakeProvider{
    func initDummyUsers(){
        self.dummyUsers.append(User(name: "Test2", id: 2, studentID: "222222", isAdmin: false, email: "test2@testmail.com", enrollments: [], login: "test2"))
        self.dummyUsers.append(User(name: "Test3", id: 3, studentID: "333333", isAdmin: false, email: "test3@testmail.com", enrollments: [], login: "test3"))
        self.dummyUsers.append(User(name: "Test4", id: 4, studentID: "444444", isAdmin: false, email: "test4@testmail.com", enrollments: [], login: "test4"))
        self.dummyUsers.append(User(name: "Test5", id: 5, studentID: "555555", isAdmin: false, email: "test5@testmail.com", enrollments: [], login: "test5"))
        self.dummyUsers.append(User(name: "Test6", id: 6, studentID: "666666", isAdmin: false, email: "test6@testmail.com", enrollments: [], login: "test6"))
    }
    
    

    
    // COURSES
    func initTestCourses(){
        var c1 = Course(id: 111, code: "DAT310", name: "Web programming", year: 2021, tag: "Spring", provider: "github", orgPath: "https://github.com/dat310-spring21", slipDays: 7)
        let c2 = Course(id: 222, code: "DAT320", name: "Operating systems", year: 2020, tag: "Fall", provider: "github", orgPath: "https://github.com/dat310-spring21", slipDays: 7)
        let c3 = Course(id: 333, code: "DAT220", name: "Database Management Systems", year: 2021, tag: "Spring", provider: "github", orgPath: "https://github.com/dat310-spring21", slipDays: 7)
        let a1 = Assignment(name: "assignment-1", id: 1, deadline: "lør. 9. jan., 23:00", courseID: 111, autoApprove: true, isGroupLab: true, skipTests: false, submissions: self.sumissionsDat310Assignment1())
        let a2 = Assignment(name: "assignment-2", id: 2, deadline: "fre. 15. jan., 23:00", courseID: 111, autoApprove: true, isGroupLab: false, skipTests: false, submissions: [])
        let a3 = Assignment(name: "assignment-3", id: 3, deadline: "fre. 29. jan., 23:00", courseID: 111, autoApprove: false, isGroupLab: false, skipTests: true, submissions: [])
        let a4 = Assignment(name: "assignment-4", id: 4, deadline: "fre. 12. jan., 23:00", courseID: 111, autoApprove: false, isGroupLab: false, skipTests: true, submissions: [])
        c1.assignments.append(a1)
        c1.assignments.append(a2)
        c1.assignments.append(a3)
        c1.assignments.append(a4)
        
        self.courses.append(c1)
        self.courses.append(c2)
        self.courses.append(c3)
    }
    
   
    // ASSIGNMENTS
    func appendAssignmentToCourse(courseId: UInt64, assignment: Assignment){
        var course = self.getCourseById(courseId: courseId)
        course?.assignments.append(assignment)
    }
    
    
    // SUBMISSIONS
    
    func sumissionsDat310Assignment1() -> [Submission]{
        var submissions: [Submission] = []
        let s1 = Submission(assignmentid: 1, approvedDate: "lør. 9. jan., 23:00", buildInfo: "buildinfo", status: Submission.Status.approved, score: 80, scoreObjects: "objects", userId: 2)
        let s2 = Submission(assignmentid: 1, approvedDate: "lør. 9. jan., 23:00", buildInfo: "buildinfo", status: Submission.Status.approved, score: 80, scoreObjects: "objects", userId: 3)
        let s3 = Submission(assignmentid: 1, approvedDate: "lør. 9. jan., 23:00", buildInfo: "buildinfo", status: Submission.Status.approved, score: 80, scoreObjects: "objects", userId: 4)
        let s4 = Submission(assignmentid: 1, approvedDate: "lør. 9. jan., 23:00", buildInfo: "buildinfo", status: Submission.Status.approved, score: 80, scoreObjects: "objects", userId: 5)
        
        submissions.append(s1)
        submissions.append(s2)
        submissions.append(s3)
        submissions.append(s4)
        
        return submissions
    }
    
    
    
    // ENROLLMENTS
    func initTestEnrollments(){
        self.createEnrollment(user: &self.currentUser, course: &self.courses[0], status: Enrollment.UserStatus.teacher, id: 1)
        self.createEnrollment(user: &self.currentUser, course: &self.courses[1], status: Enrollment.UserStatus.teacher, id: 2)
        self.createEnrollment(user: &self.currentUser, course: &self.courses[2], status: Enrollment.UserStatus.teacher, id: 3)
        
        self.enrollDummyUsersToCourse(courseIndex: 0)
        self.enrollDummyUsersToCourse(courseIndex: 1)
        
    }
    
    func enrollDummyUsersToCourse(courseIndex: Int){
        var i = 0
        for _ in self.dummyUsers{
            self.createEnrollment(user: &self.dummyUsers[i], course: &self.courses[courseIndex], status: Enrollment.UserStatus.student, id: self.courses[courseIndex].id + self.dummyUsers[i].id)
            i += 1
        }
        
    }
    
    
    
    
    func createEnrollment(user: inout User, course: inout Course, status: Enrollment.UserStatus, id: UInt64){
        let enrollment = Enrollment(id: id, courseId: course.id, userID: user.id, user: user, course: course)
        user.enrollments.append(enrollment)
        course.enrollments.append(enrollment)
    }
}
