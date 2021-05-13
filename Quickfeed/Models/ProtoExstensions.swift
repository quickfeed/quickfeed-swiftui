//
//  ProtoModelExstensions.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 04/02/2021.
//
import SwiftUI
import Foundation

extension User{
    init(name: String, id: UInt64, studentID: String, isAdmin: Bool, email: String, enrollments: [Enrollment], login: String){
        self.name = name
        self.id = id
        self.studentID = studentID
        self.isAdmin = isAdmin
        self.email = email
        self.enrollments = enrollments
        self.login = login
    }
    
}

extension Course{
    init(id: UInt64, code: String, name: String, year: UInt32, tag: String, provider: String, orgPath: String, slipDays: UInt32){
        self.id = id
        self.code = code
        self.name = name
        self.year = year
        self.tag = tag
        self.provider = provider
        self.organizationPath = orgPath
        self.slipDays = slipDays
    }
}

extension Assignment{
    init(name: String, id: UInt64, deadline: String, courseID: UInt64, autoApprove: Bool, isGroupLab: Bool, skipTests: Bool, submissions: [Submission]) {
        self.name = name
        self.id = id
        self.deadline = deadline
        self.courseID = courseID
        self.autoApprove = autoApprove
        self.isGroupLab = isGroupLab
        self.skipTests = skipTests // means it is graded manually
        self.submissions = submissions
    }
}


extension Submission{
    var buildInfoJSON: SessionBuildInfo {
        let jsonData = self.buildInfo.data(using: .utf8)!
        return try! JSONDecoder().decode(SessionBuildInfo.self, from: jsonData)
    }
    
    var scoreObj: [ScoreObj]? {
        let jsonData = self.scoreObjects.data(using: .utf8)!
        let scoreObject: [ScoreObj]? = try? JSONDecoder().decode([ScoreObj].self, from: jsonData)
        
        return scoreObject
    }
    
    init(assignmentid: UInt64, approvedDate: String, buildInfo: String, status: Submission.Status, score: UInt32, scoreObjects: String, userId: UInt64) {
        self.assignmentID = assignmentid
        self.buildInfo = buildInfo
        self.approvedDate = approvedDate
        self.status = status
        self.score = score
        self.scoreObjects = scoreObjects
        self.userID = userId
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
