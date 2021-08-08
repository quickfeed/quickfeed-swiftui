//
//  AutoGraded.swift
//  Quickfeed
//

import SwiftUI

struct AutoGraded: View {
    var assignment: Assignment
    var submission: Submission
    
    var body: some View {
        ScrollView(showsIndicators: false){
        HStack{
            Spacer()
            Text("Tests")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Text("Lab Information")
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 300)
        }
        .padding(.top)
        HStack{
            VStack{
                LabTests(submission: submission)
                Spacer()
            }
            .padding(.trailing)
            VStack{
                LabInfo(submission: submission, assignment: assignment, teacherView: false)
                    .frame(width: 300)
                Spacer()
            }
        }
        .padding(.bottom)
        Spacer()
        Divider()
        Spacer()
        Text("Feedback")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top)
        ScrollView(showsIndicators: false){
            Text(submission.buildInfoJSON.buildlog)
        }
        .frame(height: 450, alignment: .leading)
    }
    .frame(minHeight: 500, maxHeight: .infinity)
    }
}
