//
//  UserViewModel.swift
//  Quickfeed
//

import Foundation

class UserViewModel: UserViewModelProtocol {
    var provider: ProviderProtocol = ServerProvider.shared
    
    @Published var user: User?
    @Published var courses: [Course] = []
    @Published var enrollments: [Enrollment] = []
    
    init() {
        print("New UserViewModel")
    }
    
    // MARK: Users
    func setUser(userID: UInt64){
        self.provider.setUser(userID: userID)
        self.getUser()
    }
    
    func getUser() {
        self.user = provider.getUser()!
        self.getCoursesByUser()
        self.getEnrollments()
    }
    
    func updateUser(name: String, studentID: String, email: String) {
        self.user!.name = name
        self.user!.studentID = studentID
        self.user!.email = email
        
        self.provider.updateUser(user: self.user!)
        self.getUser()
    }
    
    // MARK: Enrollments
    func createEnrollment(courseID: UInt64) {
        var enrollment = Enrollment()
        
        enrollment.courseID = courseID
        enrollment.userID = self.user!.id
        
        self.provider.createEnrollment(enrollment: enrollment)
        self.getEnrollments()
    }
    
    func getEnrollmentByCourse(courseID: UInt64) -> Enrollment?{
        for enrollment in self.enrollments {
            if enrollment.courseID == courseID {
                return enrollment
            }
        }
        return nil
    }
    
    func getEnrollments() {
        self.enrollments = self.provider.getEnrollmentsByUser(userID: self.user!.id, userStatus: [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student, Enrollment.UserStatus.pending])!
        
        self.sortEnrollmentsByCode()
    }
    
    private func sortEnrollmentsByCode() {
        var enrollments = self.enrollments
        enrollments.sort { self.getCourseById(courseId: $0.courseID).code < self.getCourseById(courseId: $1.courseID).code }
        self.enrollments = enrollments
    }
    
    // MARK: Courses
    func getCourse(courseID: UInt64) -> Course? {
        for course in self.courses {
            if course.id == courseID {
                return course
            }
        }
        return nil
    }
    
    func getCourseById(courseId: UInt64) -> Course{
        return self.provider.getCourse(courseID: courseId)!
    }
    
    func getCourses() -> [Course]? {
        return provider.getCourses()
    }
    
    func getCoursesByUser() {
        self.courses = self.provider.getCoursesByUser(userID: self.user!.id, userStatus: [Enrollment.UserStatus.student, Enrollment.UserStatus.teacher])!
        self.courses = sortCourseByCode(courses: self.courses)
    }
    
    func getCoursesForNewEnrollments() -> [Course]?{
        var courses = self.getCourses()
        if courses?.count != 0 {
            for course in courses! {
                if self.enrollments.count != 0{
                    for enrollment in self.enrollments {
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
    
    func isTeacherForCourse(courseId: UInt64) -> Bool? {
        for course in self.courses {
            if course.id == courseId {
                return course.enrolled == Enrollment.UserStatus.teacher ? true : false
            }
        }
        
        return nil
    }
    
    func sortCourseByCode(courses: [Course]) -> [Course] {
        var courses = courses
        courses.sort { $0.code < $1.code }
        return courses
    }
    
    func reset() {
        
    }
}
