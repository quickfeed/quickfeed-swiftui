//
//  ResultStats.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 24/03/2021.
//

import SwiftUI


struct ResultStats: View {
    @ObservedObject var viewModel: TeacherViewModel
    
    func totalApprovedForAssignment(assignmentId: UInt64) -> Int{
        var count: Int =  0
        for enrollmentLink in viewModel.enrollmentLinks{
            for submissionLink in enrollmentLink.submissions{
                if submissionLink.hasAssignment{
                    if submissionLink.assignment.id == assignmentId{
                        if submissionLink.submission.status == .approved{
                            count += 1
                        }
                    }
                }
            }
        }
        
        return count
    }
    private func date(date: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormat.date(from: date)!
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "E, d MMM YY HH:mm"
        return stringFormatter.string(from: dateString)
    }
    
    var body: some View {
        
        VStack{
            if viewModel.enrollmentLinks.count > 0{
                List{
                    ForEach(viewModel.assignments, id: \.self){assignment in
                        HStack{
                            Text(assignment.name)
                                .font(.title)
                            Spacer()
                            Text("Deadline: \(self.date(date: assignment.deadline))")
                            
                        }
                        ProgressView(value: Float(totalApprovedForAssignment(assignmentId: assignment.id)), total: Float(viewModel.enrollmentLinks.count),  label: {Text("Approved")}, currentValueLabel: {Text("\(totalApprovedForAssignment(assignmentId: assignment.id))/\(viewModel.enrollmentLinks.count)")})
                      
                        
                        Divider()
                    }
                    
                }
            } else{
                ProgressView("Loading data")
            }
            
        }
        .navigationTitle("Stats")
        .navigationSubtitle(viewModel.currentCourse.name)
    }
}

