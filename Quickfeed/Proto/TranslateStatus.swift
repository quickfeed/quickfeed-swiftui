//
//  TranslateStatus.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import Foundation


func translateSubmissionStatus(statusCode: Submission.Status) -> String{
    switch statusCode {
    case .approved:
        return "Approved"
    case .rejected:
        return "Rejected"
    case .revision:
        return "Revision"
    default:
        return "None"
    }
}

func translateUserStatus(status: Enrollment.UserStatus) -> String{
    switch status {
    case .pending:
        return "Pending"
    case .student:
        return "Student"
    case .teacher:
        return "Teacher"
    default:
        return "None"
    }
    
}
