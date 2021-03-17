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
            Text("Hello world")
            
        }
        .navigationTitle("Groups of ")
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
