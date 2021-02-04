//
//  FakeProvider.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation

class FakeProvider: ProviderProtocol, ObservableObject{
    
    @Published var currentUser: User
    var enrollments: [Enrollment]
    var courses: [Course]
    
    init() {
        self.courses = []
        self.enrollments = []
        self.currentUser = User()
        self.initTestUser(name: "test user")
        self.initTestCourses()
        self.initTestEnrollments()
        self.enrollCurrentUser()
        self.enrollCourses()
        self.initTestAssignments()
    }
    
    
    func getUser() -> User? {
        return currentUser
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
    
    func initTestUser(name: String) {
        self.currentUser.id = 1
        self.currentUser.studentID = "111111"
        self.currentUser.name = name
        self.currentUser.isAdmin = true
        self.currentUser.enrollments = []
    }
    
    
    // ENROLLMENTS
    func initTestEnrollments(){
        self.appendTestEnrollment(course: self.courses[0], courseId: 111, user: self.currentUser, userId: 1)
        self.appendTestEnrollment(course: self.courses[1], courseId: 222, user: self.currentUser, userId: 1)
        
    }
    
    func appendTestEnrollment(course: Course, courseId: UInt64, user: User, userId: UInt64){
        var testEnrollment = Enrollment()
        testEnrollment.course = course
        testEnrollment.courseID = courseId
        testEnrollment.user = user
        testEnrollment.userID = userId
        
        
        self.enrollments.append(testEnrollment)
    }
    
    func enrollCurrentUser(){
        for enrollment in self.enrollments {
            if enrollment.userID == self.currentUser.id{
                self.currentUser.enrollments.append(enrollment)
            }
        }
    }
    
    func enrollCourses(){
        for course in self.courses{
            var courseIndex = 0
            for enrollment in self.enrollments {
                if enrollment.courseID == course.id{
                    self.courses[courseIndex].enrollments.append(enrollment)
                }
                courseIndex += 1
            }
            
        }
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
