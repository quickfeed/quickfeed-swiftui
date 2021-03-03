//
//  AutoGraded.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 03/03/2021.
//

import SwiftUI

struct AutoGraded: View {
    var assignment: Assignment
    var submission: Submission
    
    var body: some View {
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
            Divider()
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
        ScrollView{
            Text(submission.buildInfoJSON.buildlog)
        }
        .frame(height: 400, alignment: .leading)
    }
}

/*struct AutoGraded_Previews: PreviewProvider {
 static var previews: some View {
 AutoGraded()
 }
 }*/
