//
//  UserViewModel.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 01/03/2021.
//

import Foundation

class UserViewModel: UserViewModelProtocol {
    var provider: ProviderProtocol
    @Published var user: User?
    @Published var courses: [Course]?
    @Published var enrollments: [Enrollment]?
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        print("New UserViewModel")
    }
    
    // User
    
    func getUser() {
        self.user = provider.getUser()!
        self.getAllCoursesForCurrentUser()
        self.getEnrollments()
    }
    
    func updateUser(name: String, studentID: String, email: String) {
        self.user!.name = name
        self.user!.studentID = studentID
        self.user!.email = email
        self.provider.updateUser(user: self.user!)
        self.getUser()
    }
    
    // Course
    
    func getCourse(courseID: UInt64) -> Course? {
        if self.courses != nil {
            for course in self.courses! {
                if course.id == courseID {
                    return course
                }
            }
        }
        return nil
    }
    
    func getCourseById(courseId: UInt64) -> Course{
        return self.provider.getCourse(courseId: courseId)!
    }
    
    func getAllCourses() -> [Course]? {
        return provider.getCourses()
    }
    
    func getAllCoursesForCurrentUser() {
        self.courses = self.provider.getCoursesForCurrentUser()
    }
    
    func isTeacherForCourse(courseId: UInt64) -> Bool? {
        if self.courses != nil {
            for course in self.courses! {
                if course.id == courseId {
                    return course.enrolled == Enrollment.UserStatus.teacher ? true : false
                }
            }
        }
        
        return nil
    }
    
    func sortCourseByCode(courses: [Course]) -> [Course] {
        var courses = courses
        courses.sort { $0.code < $1.code }
        return courses
    }
    
    // Enrollment
    
    func createEnrollment(courseID: UInt64) {
        self.provider.createEnrollment(courseID: courseID, userID: self.user!.id)
        self.getEnrollments()
    }
    
    func getEnrollmentByCourse(courseID: UInt64) -> Enrollment?{
        if self.enrollments != nil {
            for enrollment in self.enrollments! {
                if enrollment.courseID == courseID {
                    return enrollment
                }
            }
        }
        return nil
    }
    
    func getEnrollments() {
        self.enrollments = self.provider.getEnrollmentsForUser(userId: self.user!.id)
        if self.enrollments?.count != 0 {
            self.sortEnrollmentsByCode()
        }
    }
    
    func getCoursesForNewEnrollments() -> [Course]?{
        var courses = self.getAllCourses()
        if courses?.count != 0 {
            for course in courses! {
                if self.enrollments?.count != 0{
                    for enrollment in self.enrollments! {
                        if course.id == enrollment.courseID {
                            if let index = courses!.firstIndex(of: course) {
                                courses!.remove(at: index)
                            }
                        }
                    }
                }
            }
            return courses
        }
        return nil
    }
    
    private func sortEnrollmentsByCode() {
        var enrollments = self.enrollments!
        enrollments.sort { self.getCourseById(courseId: $0.courseID).code < self.getCourseById(courseId: $1.courseID).code }
        self.enrollments = enrollments
    }
    
    
    func reset() {
        
    }
}
