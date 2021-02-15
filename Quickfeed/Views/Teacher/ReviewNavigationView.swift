//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewNavigationView: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    @Binding var selectedCourse: UInt64
    @State private var searchQuery: String = ""
    @Binding var users: [User]
    @Binding var selectedLab: UInt64
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
                
                VStack{
                    SearchFieldRepresentable(query: $searchQuery)
                    
                    LabPicker(labs: viewModel.getCourse(courseId: selectedCourse).assignments, selectedLab: $selectedLab)
        
                    Toggle("Show completed", isOn: $showCompleted)
                }
                
                
                
                List{
                    Section(header: Text(viewModel.getAssignmentById(id: selectedLab).isGroupLab ? "Groups" : "Students")){
                        ForEach(users.filter({ matchesQuery(str: $0.name) }), id: \.id){ user in
                            NavigationLink(destination: Text(user.name)){
                                SubmissionListItem(submitterName: user.name, totalReviewers: 1, reviews: 1, markedAsReady: true)
                            }
                        }
                    }
                }
            }
            .frame(alignment: .leading)
            .padding(5)
        }
        .frame(minWidth: 200)
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(selectedCourse: .constant(1),users: .constant([]), selectedLab: .constant(1))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
