//
//  NewGroup.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 28/04/2021.
//

import SwiftUI

struct NewGroup: View {
    @ObservedObject var viewModel: StudentViewModel
    @State var searchQuery: String = ""
    @State var groupName: String = ""
    @State var selectedMembers: [Enrollment] = []
    @State var isSearching: Bool = false
    
    var body: some View {
        VStack{
            SelectedMembers(selectedMembers: $selectedMembers, groupCreator: viewModel.user)
            Divider()
            HStack{
                Text("Name:")
                    .frame(width: 75, alignment: .leading)
                Spacer()
                TextField("Enter group name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}, label: {
                    Text("Create group")
                })
                .disabled(selectedMembers.count > 0 && groupName != "" ? false : true)
            }
            Divider()
            List{
                Section(header: Text("Available students")){
                    ForEach(self.filteredEnrollments(), id: \.self){ enrollment in
                        if enrollment.user.id != viewModel.user.id{
                            HStack{
                                Text(enrollment.user.name)
                                Spacer()
                                Button(action: {selectedMembers.append(enrollment)}, label: {
                                    Image(systemName: "plus.circle")
                                })
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                            Divider()
                        }
                    }
                }
            }
            .cornerRadius(10)
        }
        .padding()
        .onAppear(perform:{
            viewModel.getEnrollmentsByCourse()
            let enrollment = viewModel.getEnrollmentForCurrentCourse()
            self.selectedMembers.append(enrollment!)
        })
        .navigationTitle("New Group")
        .navigationSubtitle(viewModel.course!.name)
        .toolbar{
            ToolbarItem{
                SearchFieldToolbarItem(isSearching: $isSearching, searchQuery: $searchQuery)
            }
            ToolbarItem{
                SearchToggleToolbarItem(isSearching: $isSearching)
            }
        }
    }
    
    func filteredEnrollments() -> [Enrollment] {
        let enrollments = viewModel.enrollments
        return enrollments.filter({ matchesQuery(searchQuery: searchQuery, enrollment: $0, selectedMembers: selectedMembers) })
    }
}
