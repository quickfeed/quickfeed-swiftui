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
    @State private var isEditing = false
    var filteredGroups: [Group] {
        return viewModel.groups.filter({
            matchesQuery(group: $0)
        })
    }
    
    func sortedList() -> [Group] {
        var groups = filteredGroups
        groups.sort{
            if $0.status != $1.status{
                return $0.status != .approved && $1.status == .approved
            }
            return false
        }
        return groups
    }
    
    func matchesQuery(group: Group) -> Bool {
        if searchQuery == ""{
            return true
        }
        if group.name.lowercased().contains(searchQuery.lowercased()){
            return true
        }
        
        for user in group.users{
            if user.name.lowercased().contains(searchQuery.lowercased()) || user.studentID.lowercased().contains(searchQuery.lowercased()){
                return true
            }
        }
        
        return false
    }
    
    func updateGroup(){
        
    }
    
    var body: some View {
        
        List{
            if viewModel.groups.count > 0{
                Section(header: GroupListHeader()){
                    ForEach(sortedList(), id: \.self){ group in
                        HStack{
                            GroupListItem(group: group, isEditing: $isEditing)
                            
                        }
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
        .navigationTitle("Groups")
        .navigationSubtitle(viewModel.course.name)
        .toolbar{
            ToolbarItem(id: "edit"){
                Toggle(isOn: $isEditing, label: {
                    Image(systemName: "square.and.pencil")
                })
            }
            ToolbarItem{
                SearchFieldToolbarItem(isSearching: $isSearching, searchQuery: $searchQuery)
            }
            ToolbarItem{
                SearchToggleToolbarItem(isSearching: $isSearching)
            }
            
            
        }
        
    }
}


