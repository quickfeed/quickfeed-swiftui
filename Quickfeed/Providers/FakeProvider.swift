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
        self.currentUser = User()
        self.currentUser = self.testUser(name: "Current user", id: 1, studentID: "111111", isAdmin: true, enrollments: [])
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
    
   
    
    func initDummyUsers(){
        self.dummyUsers.append(self.testUser(name: "Test2", id: 2, studentID: "222222", isAdmin: false, enrollments: []))
        
        self.dummyUsers.append(self.testUser(name: "Test2", id: 2, studentID: "222222", isAdmin: false, enrollments: []))
        
        self.dummyUsers.append(self.testUser(name: "Test2", id: 2, studentID: "222222", isAdmin: false, enrollments: []))
    }
    
    
    func testUser(name: String, id: UInt64, studentID: String, isAdmin: Bool, enrollments: [Enrollment]) -> User{
        var user = User()
        user.name = name
        user.id = id
        user.studentID = studentID
        user.isAdmin = isAdmin
        user.enrollments = enrollments
        
        return user
    }
    
    
    // ENROLLMENTS
    func initTestEnrollments(){
        self.createEnrollment(user: &self.currentUser, course: &self.courses[0], status: Enrollment.UserStatus.teacher)
        self.createEnrollment(user: &self.currentUser, course: &self.courses[1], status: Enrollment.UserStatus.teacher)
        
        var i = 0
        for _ in self.dummyUsers{
            var j = 0
            for _ in self.courses{
                self.createEnrollment(user: &self.dummyUsers[i], course: &courses[j], status: Enrollment.UserStatus.student)
                j += 1
            }
            i += 1
        }
        
    }
    
    func createEnrollment(user: inout User, course: inout Course, status: Enrollment.UserStatus){
        var enrollment = Enrollment()
        enrollment.user = user
        enrollment.course = course
        enrollment.userID = user.id
        enrollment.courseID = course.id
        enrollment.status = status
        
        user.enrollments.append(enrollment)
        course.enrollments.append(enrollment)
    }

    
    func updateUser(user: User) -> Bool{
        return true
    }
    
 
    
    
    // COURSES
    func initTestCourses(){
        var c1 = self.initTestCourse(id: 111, code: "DAT310", name: "Webprogramming", year: 2021, tag: "Spring", provider: "github")
        let c2 =  self.initTestCourse(id: 222, code: "DAT320", name: "Operating systems", year: 2020, tag: "Fall", provider: "github")
        let c3 = self.initTestCourse(id: 333, code: "DAT220", name: "Database Management Systems", year: 2021, tag: "Spring", provider: "github")
        
        let a1 = self.initTestAssignment(name: "assignment-1", id: 1, deadline: "lør. 9. jan., 23:00", courseId: 111, autoApprove: true)
        let a2 = self.initTestAssignment(name: "assignment-2", id: 2, deadline: "fre. 15. jan., 23:00", courseId: 111, autoApprove: true)
        let a3 = self.initTestAssignment(name: "assignment-3", id: 3, deadline: "fre. 29. jan., 23:00", courseId: 111, autoApprove: false)
        
        c1.assignments.append(a1)
        c1.assignments.append(a2)
        c1.assignments.append(a3)
        
        self.courses.append(c1)
        self.courses.append(c2)
        self.courses.append(c3)
    }
    
    
    func initTestCourse(id: UInt64, code: String, name: String, year: UInt32, tag: String, provider: String) -> Course{
        var testCourse = Course()
        testCourse.id = id
        testCourse.year = year
        testCourse.provider = provider
        testCourse.tag = tag
        testCourse.code = code
        testCourse.name = name
        testCourse.enrollments = []
        testCourse.assignments = []
        return testCourse
       
        
    }
    
    func appendAssignmentToCourse(courseId: UInt64, assignment: Assignment){
        var course = self.getCourseById(courseId: courseId)
        course?.assignments.append(assignment)
        
    }
    
    
    // ASSIGNMENTS
    func initTestAssignments(){
        
        
        let a1 = self.initTestAssignment(name: "assignment-1", id: 1, deadline: "lør. 9. jan., 23:00", courseId: 111, autoApprove: true)
        let a2 = self.initTestAssignment(name: "assignment-2", id: 2, deadline: "fre. 15. jan., 23:00", courseId: 111, autoApprove: true)
        let a3 = self.initTestAssignment(name: "assignment-3", id: 3, deadline: "fre. 29. jan., 23:00", courseId: 111, autoApprove: false)
        
        self.appendAssignmentToCourse(courseId: 111, assignment: a1)
        self.appendAssignmentToCourse(courseId: 111, assignment: a2)
        self.appendAssignmentToCourse(courseId: 111, assignment: a3)
    }
    
    func initTestAssignment(name: String, id: UInt64, deadline: String, courseId: UInt64, autoApprove: Bool) -> Assignment{
        var testAssignment = Assignment()
        testAssignment.name = name
        testAssignment.id = id
        testAssignment.deadline = deadline
        testAssignment.autoApprove = autoApprove
        testAssignment.courseID = courseId
        
        return testAssignment
    }
    
    
    
    
    
    
    
    
}
