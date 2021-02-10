//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewNavigatorView: View {
    @State private var searchQuery: String = ""
    @State var users: [User]
    @Binding var selectedLab: UInt64
    @EnvironmentObject var viewModel: TeacherViewModel
    @State private var showCompleted: Bool = true
    
    
    func matchesQuery(str: String) -> Bool{
        if searchQuery != "" && !str.lowercased().contains(self.searchQuery.lowercased()){
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Review Submissions")
                    .font(.headline)
                
                SearchFieldRepresentable(query: $searchQuery)
                
                LabPicker(labs: viewModel.courses[0].assignments, selectedLab: $selectedLab)
                    .frame(width: 120)
                Toggle("Show completed", isOn: $showCompleted)
                
                
                
                
                
                
                List{
                    Section(header: Text("Students")){
                        ForEach(users.filter({ matchesQuery(str: $0.name) }), id: \.id){ user in
                            NavigationLink(destination: Text(user.name)){
                                Text(user.name)
                            }
                        }
                    }
                }
            }
            .padding(5)
        }
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigatorView(users: [], selectedLab: .constant(1))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
