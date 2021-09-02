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
    @State private var groupMembers: [Enrollment] = []
    
    @State private var testName: [String] = ["Truls Jørgensen", "Hanne Svendsen", "Bodil Nilsen", "Jonas Borgersen", "Børge Børgersen", "Andrine Hillesen", "Henrik Karlsen", "Marius Kull", "Hanne Skage", "Julie Gruve", "Bjørn Borger", "Malin Hallosen", "Andreas Nilsen", "Mikkel Rev", "Rolf Rive", "Torkel Testis", "Aleksander Finnestad", "Daniel Sven", "Sven Kullestad", "Bent Johnsen", "Tuva Beckman", "Mary Storhammer", "Hege Tullball", "Alexandria Hilde"]
    @State private var testGroupName: [String] = ["Ola Nordmann", "Kari Nordmann"]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {}){
                    Text("Create")
                }
                .foregroundColor(.clear)
                .disabled(true)
                Spacer()
                Text("NewGroup")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { viewModel.createGroup(name: groupName, enrollments: groupMembers) }){
                    Text("Create")
                }
                .foregroundColor((groupMembers.count > 0 && groupName != "") ? .primary : .clear)
                .disabled(!(groupMembers.count > 0 && groupName != ""))
            }
            HStack{
                Text("GroupName:")
                Spacer()
                TextField("Enter your groupname...", text: $groupName)
            }
            Divider()
            HStack{
                Text("Members:")
                Spacer()
                List{
                    ForEach(groupMembers, id: \.self){ enrollment in
                        HStack{
                            Spacer()
                            Text(testGroupName.randomElement()!)
                            //Text(enrollment.user.name)
                            if enrollment != viewModel.getEnrollment()!{
                                Image(systemName: "xmark")
                                    .onTapGesture {
                                        groupMembers.remove(at: groupMembers.firstIndex(of: enrollment)!)
                                    }
                            }
                        }
                    }
                }
                .frame(maxHeight: 80)
            }
            Divider()
            List{
                Section(header: Text("Available students")){
                    ForEach(viewModel.enrollments, id: \.self){ enrollment in
                        if !groupMembers.contains(enrollment){
                            HStack{
                                Text(testName.randomElement()!)
                                //Text(enrollment.user.name)
                                Spacer()
                                Image(systemName: "plus")
                                    .onTapGesture {
                                        groupMembers.append(enrollment)
                                    }
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
            self.groupMembers.append(viewModel.getEnrollment()!)
        })
    }
}
