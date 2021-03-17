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
                    ForEach(self.viewModel.groups, id: \.self){ group in
                        Text(group.name)
                    }
                    
                }
            }
            else {
                Text("No groups to show")
            }
        }
        .navigationTitle("Groups of \(viewModel.currentCourse.name)")
        .toolbar{
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
