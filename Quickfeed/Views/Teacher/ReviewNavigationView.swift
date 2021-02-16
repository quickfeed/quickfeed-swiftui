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
    @Binding var enrolledUsers: [User]
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
                    LabPicker(labs: viewModel.getManuallyGradedAssignments(courseId: selectedCourse), selectedLab: $selectedLab)
        
                    SearchFieldRepresentable(query: $searchQuery)
                    
                    Toggle("Show completed", isOn: $showCompleted)
                }
                
                
                
                List{
                    Section(header: Text("Submissions")){
                        ForEach(enrolledUsers.filter({ matchesQuery(str: $0.name) }), id: \.id){ user in
                            NavigationLink(destination: Text(user.name)){
                                SubmissionListItem(submitterName: user.name, totalReviewers: 1, reviews: 1, markedAsReady: true)
                            }
                        }
                    }
                    
                }
            }
            .frame(alignment: .leading)
            
        }
        .frame(minWidth: 200)
        .padding(2)
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(selectedCourse: .constant(1), enrolledUsers: .constant([]), selectedLab: .constant(1))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
