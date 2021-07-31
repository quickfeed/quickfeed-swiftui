//
//  AssignmentView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 19/04/2021.
//

import SwiftUI

struct AssignmentView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var assignment: Assignment?
    var body: some View {
        VStack{
            Text("\(assignment!.name)")
                .font(.title)
            
            Divider()
            VStack{
                HStack{
                    Text("Deadline:")
                    Spacer()
                    Text(date(date: assignment!.deadline))
                }
                Divider()
                HStack{
                    Text("Graded manually:")
                    Spacer()
                    Text(assignment!.skipTests ? "true" : "false")
                }
                Divider()
                HStack{
                    Text("Automatic approval:")
                    Spacer()
                    if assignment!.skipTests{
                        Text("false")
                    } else{
                        Text(assignment!.autoApprove ? "true" : "false")
                    }
                    
                }
                Divider()
            }
            .padding()
            if assignment!.skipTests{
                GradingCriterionView(viewModel: viewModel, assignment: assignment!)
            }
            Spacer()
            
        }
        .frame(minWidth: 550)
        .padding()
    }
}
