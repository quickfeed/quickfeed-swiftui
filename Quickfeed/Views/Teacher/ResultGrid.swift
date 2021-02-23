//
//  ResultGrid.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultGrid: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    @Binding var displayingSubmission: Bool
    @Binding var selectedCourse: UInt64
    @State var users: [User] = []
    @State var searchQuery: String = ""
    
    
    var body: some View {
        VStack{
            Text("Results for \(viewModel.getCourse(courseId: selectedCourse).name)")
            
            HStack{
                SearchFieldRepresentable(query: $searchQuery)
                    .frame(width: 180)
                
                ForEach(self.viewModel.getAssignments(courseId: selectedCourse), id: \.self) {assignment in
                    Text(assignment.name)
                }
            }
            
            ForEach(self.filteredUsers().indices, id: \.self){ i in
                
                MemberListItem(user: self.filteredUsers()[i])
                    
                    .frame(maxWidth: .infinity)
                    .listRowBackground(RoundedRectangle(cornerRadius: 4)
                                        .foregroundColor(Color(.unemphasizedSelectedTextBackgroundColor))
                                        .opacity(i % 2 == 0 ? 0 : 100)
                    )
            }
            Spacer()
        }
        .onAppear(perform: {
            users = viewModel.getStudentsForCourse(courseId: self.selectedCourse)
        })
    }
    
    func filteredUsers() -> [User] {
        return users.filter({ matchesQuery(user: $0) })
    }
    
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
}

struct ResultGrid_Previews: PreviewProvider {
    static var previews: some View {
        ResultGrid(displayingSubmission: .constant(false), selectedCourse: .constant(111))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
