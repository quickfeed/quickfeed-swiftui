//
//  AdminViewModel.swift
//  Quickfeed
//

import Foundation

class AdminViewModel: UserViewModelProtocol {
    static let shared: AdminViewModel = AdminViewModel()
    var provider: ProviderProtocol = ServerProvider.shared
    var user: User = ServerProvider.shared.getUser()!
    @Published var users: [User]?
    @Published var courses: [Course]?
    
    private init() {
        print("New AdminViewModel")
        getUsers()
        getCourses()
    }
    
    // Users
    func getUsers(){
        self.users = provider.getUsers()
    }
    
    func updateUser(user: User){
        var user = user
        user.isAdmin = !user.isAdmin
        provider.updateUser(user: user)
        self.getUsers()
    }
    
    // Courses
    func createCourse(name: String, code: String, year: String, tag: String, slipDays: UInt32){
        var course = Course()
        course.name = name
        course.code = code
        course.year = UInt32(year)!
        course.tag = tag
        course.slipDays = slipDays
        provider.updateCourse(course: course)
        self.getCourses()
    }
    
    func updateCourse(course: Course, name: String, code: String, year: String, tag: String, slipDays: UInt32){
        var course = course
        course.name = name
        course.code = code
        course.year = UInt32(year)!
        course.tag = tag
        course.slipDays = slipDays
        provider.updateCourse(course: course)
        self.getCourses()
    }
    
    func getCourses(){
        self.courses = provider.getCourses()
    }
    
    func reset() {
        
    }
}
