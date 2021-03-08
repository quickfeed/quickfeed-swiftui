//
//  TranslateStatus.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/03/2021.
//

import Foundation
import SwiftUI

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

func getColorForSubmissionStatus(submissionStatus: Submission.Status) -> Color {
    switch (submissionStatus){
    case Submission.Status.approved:
        return .green
    case Submission.Status.rejected:
        return .red
    case Submission.Status.revision:
        return .orange
    default:
        return .blue
    }
}

func getImageForSubmissionStatus(submission: Submission.Status) -> Image{
    switch (submission){
    case Submission.Status.approved:
        return Image(systemName: "checkmark.circle")
    case Submission.Status.rejected:
        return Image(systemName: "multiply.circle")
    default:
        return Image(systemName: "circle")
    }
}

func getColorForGradingCriterionGrade(grade: GradingCriterion.Grade) -> Color {
    switch (grade){
    case GradingCriterion.Grade.passed:
        return .green
    case GradingCriterion.Grade.failed:
        return .red
    default:
        return .blue
    }
}

func getImageForGradingCriterionGrade(grade: GradingCriterion.Grade) -> Image{
    switch (grade){
    case GradingCriterion.Grade.passed:
        return Image(systemName: "checkmark.circle")
    case GradingCriterion.Grade.failed:
        return Image(systemName: "multiply.circle")
    default:
        return Image(systemName: "circle")
    }
}

func getSystemNameForGradingCriterionGrade(grade: GradingCriterion.Grade) -> String{
    switch grade{
    case .passed:
        return "checkmark.circle"
    case .failed:
        return "multiply.circle"
    default:
        return "circle"
    }
}


