//
//  AssignmentsView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/04/2021.
//

import SwiftUI

struct AssignmentsView: View {
    @ObservedObject var viewModel: TeacherViewModel
    var body: some View {
        
        List{
            ForEach(viewModel.assignments, id: \.self){ assignment in
                HStack{
                    Text("\(assignment.name)")
                    Spacer()
                    Button(action: {print(assignment.gradingBenchmarks[0].heading)}, label: {
                        Text("Load From File")
                    })
                    .disabled(assignment.skipTests ? false : true)
                }
                Divider()
            }
        }
        
        
        
        
        .navigationTitle("Assignments")
        .navigationSubtitle(viewModel.currentCourse.name)
        .toolbar{
            ToolbarItem{
                Button(action: {}, label: {
                    Text("Update Course Assignments")
                })
            }
        }
    }
}
