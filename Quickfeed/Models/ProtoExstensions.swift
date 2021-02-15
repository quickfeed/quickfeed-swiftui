//
//  ProtoModelExstensions.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 04/02/2021.
//

import Foundation


extension User{
    init(name: String, id: UInt64, studentID: String, isAdmin: Bool, enrollments: [Enrollment]){
        self.name = name
        self.id = id
        self.studentID = studentID
        self.isAdmin = isAdmin
        self.enrollments = enrollments
    }
    
}

extension Course{
    init(id: UInt64, code: String, name: String, year: UInt32, tag: String, provider: String, orgPath: String){
        self.id = id
        self.code = code
        self.name = name
        self.year = year
        self.tag = tag
        self.provider = provider
        self.organizationPath = orgPath
    }
}

extension Assignment{
    init(name: String, id: UInt64, deadline: String, courseID: UInt64, autoApprove: Bool, isGroupLab: Bool, skipTests: Bool) {
        self.name = name
        self.id = id
        self.deadline = deadline
        self.courseID = courseID
        self.autoApprove = autoApprove
        self.isGroupLab = isGroupLab
        self.skipTests = skipTests // means it is graded manually
    }
}


extension Submission{
    init(assignmentid: UInt64, approvedDate: String, buildInfo: String) {
        self.assignmentID = assignmentid
        self.approvedDate = approvedDate
        self.buildInfo = buildInfo
    }
}

extension Enrollment{
    init(id: UInt64, courseId: UInt64, userID: UInt64, user: User, course: Course) {
        self.id = id
        self.courseID = courseId
        self.userID = userID
        self.groupID = groupID
        self.user = user
        self.course = course
    }
}
