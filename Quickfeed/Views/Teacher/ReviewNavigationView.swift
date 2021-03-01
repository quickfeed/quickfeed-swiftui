//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var selectedCourse: UInt64
    @State private var searchQuery: String = ""
    @Binding var enrolledUsers: [User]
    @Binding var selectedLab: UInt64
    @State private var showCompleted: Bool = true
    
    
    func matchesQuery(user: User) -> Bool{
        if searchQuery == ""{
            return true
        }
        if  user.name.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if  user.email.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if user.studentID.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        if user.login.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        return false
    }
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                LabPicker(labs: viewModel.manuallyGradedAssignments, selectedLab: $selectedLab)
                    .padding(2)
                
                SearchFieldRepresentable(query: $searchQuery)
                    .padding(2)
                
                Toggle("Show completed", isOn: $showCompleted)
                
                List{
                    Section(header: Text("Submissions")){
                        ForEach(enrolledUsers.filter({ matchesQuery(user: $0) }), id: \.id){ user in
                            NavigationLink(destination: Text(user.name)){
                                SubmissionListItem(submitterName: user.name, totalReviewers: 1, reviews: 1, markedAsReady: true)
                            }
                        }
                    }
                }
                .padding(2)
                
            }
            .frame(minWidth: 300)
            
        }
        
        
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedCourse: .constant(1), enrolledUsers: .constant([]), selectedLab: .constant(1))
    }
}
