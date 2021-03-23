//
//  GroupsView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 16/03/2021.
//

import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel: TeacherViewModel
    
    @State var isAddingGroup = false
    var body: some View {
        SwiftUI.Group{
            if isAddingGroup{
                AddGroupForm(viewModel: viewModel)
            } else{
                GroupList(viewModel: viewModel)
            }
        }
        .toolbar{
            ToolbarItem(id: "add", placement: isAddingGroup ? .navigation : .status){
                Button(action: {isAddingGroup.toggle()}, label: {
                    Label("Add Group", systemImage: isAddingGroup ?"chevron.backward" : "plus")

                })
                .help(isAddingGroup ? "back" : "Add group")
                .keyboardShortcut("a")
            }
        }
    
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
