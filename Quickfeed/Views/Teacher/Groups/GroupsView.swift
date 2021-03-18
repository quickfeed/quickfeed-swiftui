//
//  GroupsView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 16/03/2021.
//

import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var searchQuery: String = ""
    var body: some View {
        VStack{
            if viewModel.groups.count > 0{
                List{
                    Section(header: GroupListHeader()){
                        ForEach(viewModel.groups, id: \.self){ group in
                            GroupListItem(group: group)
                                .focusable(true, onFocusChange: {_ in 
                                    print(group.name)
                                })
                            Divider()
                        }
                    }
                    
                }
            }
            else {
                Text("No groups to show")
            }
        }
        .padding()
        .navigationTitle("Groups of \(viewModel.currentCourse.name)")
        .toolbar{
            Button(action: {}, label: {
                Image(systemName: "plus")
            })
            .help("Add new group")
            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
