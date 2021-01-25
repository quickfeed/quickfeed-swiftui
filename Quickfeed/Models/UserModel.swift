//
//  User.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import Foundation

struct UserModel: Identifiable {
    let id: UUID
    var name: String
    var role: String
    var enrolledIn: [StudentCourse]
    
    init(id: UUID = UUID(), name: String, role: String, enrolledIn: [StudentCourse]) {
        self.id = id
        self.name = name
        self.role = role
        self.enrolledIn = enrolledIn
    }
    
}

extension UserModel{
    static var data: [UserModel]{
        [
            UserModel(name: "Testuser", role: "Student", enrolledIn: StudentCourse.data)
        ]
    }
}
