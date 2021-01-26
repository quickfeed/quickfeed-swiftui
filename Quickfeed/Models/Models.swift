//
//  User.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import Foundation

struct UserModel {
    var id: Int
    var name: String
    var avatarUrl: String?
    var studentId: String
    var isAdmin: Bool
}

struct CourseModel: Codable{
    var id: Int
    var name: String
    var code: String
    var year: Int
    
}

struct AssignmentModel{
    var id: Int
    var courseId: Int
    var name: String
    var deadLine: String
    var autoApprove: Bool
    var scoreLimit: Int
    
}

struct EnrollmentModel{
    var courseID: Int
    var userID: Int
    
}

struct AllSubmissionsForEnrollment {
    var course: CourseModel
    var enrollment: EnrollmentModel
    var labs: [AssignmentSubmission]
    
}

struct AssignmentSubmission {
    var assignment: AssignmentModel
    var submission: Submission?
}

struct BuildInfo {
    var buildId: Int
    var buildDate: Date
    var buildLog: Int
    var execTime: Int
}

struct TestCases {
    var testName: String
    var score: Int
    var maxScore: Int
    var weight: Int
}

struct SubmissionModel {
    var id: Int
    var userId: Int
    var groupId: Int
    var assignmentId: Int
    var passedTests: Int
    var failedTests: Int
    var score: Int
    var buildId: Int
    var buildDate: Date
    var executionTime: Int
    var buildLog: String
    var testCases:[TestCases]
    var reviews: [Review]
    var released: Bool
    var status: Submission.Status
    var approvedDate: String
}
