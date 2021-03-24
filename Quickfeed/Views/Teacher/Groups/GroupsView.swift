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
        VStack{
            if isAddingGroup{
                AddGroupForm(viewModel: viewModel)
            } else{
                GroupList(viewModel: viewModel)
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .status){
                Toggle(isOn: $isAddingGroup, label: {
                    Image(systemName: "plus")
                })
                .help("Add new group")
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
