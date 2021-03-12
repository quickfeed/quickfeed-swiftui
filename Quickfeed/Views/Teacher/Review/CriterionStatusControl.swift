//
//  CriterionStatusControl.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct CriterionStatusControl: View {
    @Binding var criterionStatus: GradingCriterion.Grade
    var body: some View {
        HStack{
            Button(action: { criterionStatus = .passed }, label: {
                Image(systemName: getSystemNameForGradingCriterionGrade(grade: .passed))
                    .foregroundColor(criterionStatus == .passed ? getColorForGradingCriterionGrade(grade: .passed) : .gray)
            })
            .buttonStyle(PlainButtonStyle())
            Button(action: { criterionStatus = .none }, label: {
                Image(systemName: getSystemNameForGradingCriterionGrade(grade: .none))
                    .foregroundColor(criterionStatus == .none ? getColorForGradingCriterionGrade(grade: .none) : .gray)
            })
            .buttonStyle(PlainButtonStyle())
            Button(action: { criterionStatus = .failed }, label: {
                Image(systemName: getSystemNameForGradingCriterionGrade(grade: .failed))
                    .foregroundColor(criterionStatus == .failed ? getColorForGradingCriterionGrade(grade: .failed) : .gray)
            })
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct CriterionStatusControl_Previews: PreviewProvider {
    static var previews: some View {
        CriterionStatusControl(criterionStatus: .constant(.passed))
    }
}
