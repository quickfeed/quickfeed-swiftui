//
//  ModelTestData.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 26/01/2021.
//

import Foundation

extension UserModel{
    static var data: [UserModel]{
        [
            UserModel(id: 1, name: "Oskar", avatarUrl: "", studentId: "111111", isAdmin: false),
            UserModel(id: 2, name: "Test", avatarUrl: "", studentId: "222222", isAdmin: false),
            UserModel(id: 3, name: "Test Admin", avatarUrl: "", studentId: "333333", isAdmin: true)
        ]
    }
}

extension CourseModel{
    static var data: [CourseModel]{
        [
            CourseModel(id: 1, name: "Webprogramming", code: "DAT310" , year: 2021),
            CourseModel(id: 2, name: "Operating systems", code: "DAT320" , year: 2021)
        ]
    }
}

extension AllSubmissionsForEnrollment{
    static var data: [AllSubmissionsForEnrollment]{
        [
            AllSubmissionsForEnrollment(course: CourseModel.data[0], enrollment: EnrollmentModel(courseID: 1, userID: 1), labs: AssignmentSubmission.data)
        ]
    }
}

extension AssignmentModel{
    static var data: [AssignmentModel]{
        [
            AssignmentModel(id: 1, courseId: 1, name: "lab1", deadLine: "23/09", autoApprove: true, scoreLimit: 80)
        ]
    }
}

extension AssignmentSubmission {
    static var data: [AssignmentSubmission]{
        [
            AssignmentSubmission(assignment: AssignmentModel.data[0], submission: nil)
        ]
    }
}
