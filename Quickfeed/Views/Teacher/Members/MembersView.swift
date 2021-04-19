//
//  MembersView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 16/02/2021.
//

import SwiftUI

struct MembersView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var searchQuery: String = ""
    @State private var isEditing = false
    @State var isSearching: Bool = false
    
    func filteredEnrollments() -> [Enrollment] {
        return viewModel.enrollments.filter({ matchesQuery(user: $0.user) })
    }
    
    var body: some View {
        List{
            Section(header: MemberListHeader(courseTotalSlipDays: self.viewModel.currentCourse.slipDays)){
                ForEach(self.filteredEnrollments(), id: \.self){ enrollment in
                    MemberListItem(viewModel: viewModel, enrollment: enrollment, isEditing: $isEditing)
                    Divider()
                }
            }
        }
        .onAppear(perform: {
            viewModel.loadEnrollments()
        })
        .navigationTitle("Members")
        .navigationSubtitle(viewModel.currentCourse.name)

        .toolbar{
            ToolbarItem{
                Toggle(isOn: $isEditing, label: {
                    Image(systemName: "square.and.pencil")
                })
                .help("Manage users")
            }
            ToolbarItem{
                if !isSearching{
                Toggle(isOn: $isSearching, label: {
                    Image(systemName: "magnifyingglass")
                })
                .keyboardShortcut("f")
                } else {
                    SearchFieldRepresentable(query: $searchQuery)
                        .frame(minWidth: 200, maxWidth: 350)
                        .onExitCommand(perform: {self.isSearching = false})
                }
            }
            ToolbarItem{
                if isSearching{
                    Toggle(isOn: $isSearching, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .keyboardShortcut("f")
                    .labelsHidden()
                }
            }
        }
    }

    func matchesQuery(user: User) -> Bool{
        if searchQuery == ""{
            return true
        }
        if  user.name.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if  user.email.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if user.studentID.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if user.login.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        return false
    }
}

