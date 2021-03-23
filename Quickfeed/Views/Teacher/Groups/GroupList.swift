//
//  GroupList.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/03/2021.
//

import SwiftUI

struct GroupList: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var searchQuery: String = ""
    @State var isSearching: Bool = false
    @State private var showingPopover = true
    var body: some View {
        
        
        
        List{
            if viewModel.groups.count > 0{
                Section(header: GroupListHeader()){
                    ForEach(viewModel.groups, id: \.self){ group in
                        GroupListItem(group: group)
                        Divider()
                    }
                }
                
            }
            else{
                Text("No groups to show")
            }
        }
        .onAppear(perform: {
            viewModel.loadGroups()
        })
        .navigationTitle("Groups of \(viewModel.currentCourse.name)")
        .toolbar{
            ToolbarItem{
                if !isSearching{
                Toggle(isOn: $isSearching, label: {
                    Image(systemName: "magnifyingglass")
                })
                .keyboardShortcut("f")
                } else {
                    SearchFieldRepresentable(query: $searchQuery)
                        .frame(minWidth: 200, maxWidth: 350)
                }
                
               
                
            }
            
        }
        
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
