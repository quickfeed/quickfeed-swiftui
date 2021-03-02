//
//  ReviewNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var searchQuery: String = ""
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
                        ForEach(viewModel.users.filter({ matchesQuery(user: $0) }), id: \.id){ user in
                            NavigationLink(destination: Text(user.name)){
                                SubmissionListItem(submitterName: user.name, totalReviewers: 1, reviews: 1, markedAsReady: true)
                            }
                        }
                    }
                }
                
                
            }
            .frame(minWidth: 300)
            .padding(.horizontal)
            
        }
        
        
        
    }
}

struct ReviewNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedLab: .constant(1))
    }
}
