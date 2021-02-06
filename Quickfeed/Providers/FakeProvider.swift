//
//  FakeProvider.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation

class FakeProvider: ProviderProtocol, ObservableObject{
    
    
    @Published var currentUser: User
    var dummyUsers: [User]
    var courses: [Course]
    
    init() {
        self.courses = []
        self.dummyUsers = []
        self.currentUser = User(name: "Current user", id: 1, studentID: "111111", isAdmin: true, enrollments: [])
        self.initTestCourses()
        self.initTestEnrollments()
        self.initTestAssignments()
        self.initDummyUsers()
    }
    
    
    func getUser() -> User? {
        return currentUser
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
    
    func getCourses() -> [Course] {
        return self.courses
    }
    
    func updateUser(user: User) -> Bool{
        return true
    }
    
    func getUsers() -> [User] {
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
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.Type) -> [AllSubmissionsForEnrollment] {
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

// Contains methods not present in the protocol, used for testingx
extension FakeProvider{
    
    func initDummyUsers(){
        self.dummyUsers.append(User(name: "Test2", id: 2, studentID: "222222", isAdmin: false, enrollments: []))
        self.dummyUsers.append(User(name: "Test3", id: 2, studentID: "333333", isAdmin: false, enrollments: []))
        self.dummyUsers.append(User(name: "Test4", id: 2, studentID: "444444", isAdmin: false, enrollments: []))
    }
    
    // COURSES
    func initTestCourses(){
        var c1 = Course(id: 111, code: "DAT310", name: "Webprogramming", year: 2021, tag: "Spring", provider: "github")
        let c2 = Course(id: 222, code: "DAT320", name: "Operating systems", year: 2020, tag: "Fall", provider: "github")
        let c3 = Course(id: 333, code: "DAT220", name: "Database Management Systems", year: 2021, tag: "Spring", provider: "github")
        let a1 = Assignment(name: "assignment-1", id: 1, deadline: "lør. 9. jan., 23:00", courseID: 111, autoApprove: true)
        let a2 = Assignment(name: "assignment-2", id: 2, deadline: "fre. 15. jan., 23:00", courseID: 111, autoApprove: true)
        let a3 = Assignment(name: "assignment-3", id: 3, deadline: "fre. 29. jan., 23:00", courseID: 111, autoApprove: false)
        c1.assignments.append(a1)
        c1.assignments.append(a2)
        c1.assignments.append(a3)
        self.courses.append(c1)
        self.courses.append(c2)
        self.courses.append(c3)
    }
    
    func appendAssignmentToCourse(courseId: UInt64, assignment: Assignment){
        var course = self.getCourseById(courseId: courseId)
        course?.assignments.append(assignment)
    }
    
    // ASSIGNMENTS
    func initTestAssignments(){
        let a1 = Assignment(name: "assignment-1", id: 1, deadline: "lør. 9. jan., 23:00", courseID: 111, autoApprove: true)
        let a2 = Assignment(name: "assignment-2", id: 2, deadline: "fre. 15. jan., 23:00", courseID: 111, autoApprove: true)
        let a3 = Assignment(name: "assignment-3", id: 3, deadline: "fre. 29. jan., 23:00", courseID: 111, autoApprove: false)
        self.appendAssignmentToCourse(courseId: 111, assignment: a1)
        self.appendAssignmentToCourse(courseId: 111, assignment: a2)
        self.appendAssignmentToCourse(courseId: 111, assignment: a3)
    }
    
    
    // ENROLLMENTS
    func initTestEnrollments(){
        self.createEnrollment(user: &self.currentUser, course: &self.courses[0], status: Enrollment.UserStatus.teacher, id: 1)
        self.createEnrollment(user: &self.currentUser, course: &self.courses[1], status: Enrollment.UserStatus.teacher, id: 2)
        
        var enrId: UInt64 = 1
        var i = 0
        for _ in self.dummyUsers{
            var j = 0
            for _ in self.courses{
                self.createEnrollment(user: &self.dummyUsers[i], course: &courses[j], status: Enrollment.UserStatus.student, id: enrId)
                j += 1
                enrId += 1
            }
            i += 1
        }
    }
    
    func createEnrollment(user: inout User, course: inout Course, status: Enrollment.UserStatus, id: UInt64){
        let enrollment = Enrollment(id: id, courseId: course.id, userID: user.id, user: user, course: course)
        user.enrollments.append(enrollment)
        course.enrollments.append(enrollment)
    }
}
