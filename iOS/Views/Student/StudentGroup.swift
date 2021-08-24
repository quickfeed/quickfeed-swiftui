//
//  StudentGroup.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct StudentGroup: View {
    @ObservedObject var viewModel: StudentViewModel
    
    @State private var groupName: String = ""
    
    var body: some View {
        VStack{
            Text("NewGroup")
                .font(.title)
                .fontWeight(.bold)
            HStack{
                Text("GroupName:")
                Spacer()
                TextField("Enter your groupname...", text: $groupName)
            }
            Divider()
            HStack{
                Text("Members:")
                Spacer()
                Text(groupName)
            }
            Divider()
            List{
                Section(header: Text("Available students")){
                    ForEach(viewModel.enrollments, id: \.self){ enrollment in
                        if enrollment.user.id != viewModel.user.id{
                            HStack{
                                Text(enrollment.user.name)
                                Spacer()
                                Image(systemName: "plus")
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            .cornerRadius(10.0)
            Spacer()
        }
        .padding([.leading, .bottom, .trailing])
        .onAppear(perform: {
            viewModel.getEnrollmentsByCourse()
        })
    }
}
