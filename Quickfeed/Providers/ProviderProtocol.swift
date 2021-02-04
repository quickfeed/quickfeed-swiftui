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
    
    func getCourses() -> [Course]
    func changeName(newName: String)
    func getCoursesForCurrentUser() -> [Course]?
    func isAuthorizedTeacher() -> Bool
    func getAssignments(courseID: UInt64) -> [Assignment]
    func getUsersForCourse(course: Course) -> [User]

    
}
