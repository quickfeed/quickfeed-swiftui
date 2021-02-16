//
//  MembersView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 16/02/2021.
//

import SwiftUI

struct MembersView: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    var course: Course
    @State var searchQuery: String = ""
    @State var users: [User] = []
    
    
    func matchesQuery(str: String) -> Bool{
        if searchQuery != "" && !str.lowercased().contains(self.searchQuery.lowercased()){
            return false
        }
        return true
    }
    
    var body: some View {
        VStack {
            Text("Users enrolled in \(self.course.name)")
            SearchFieldRepresentable(query: $searchQuery)
            
            List{
                HStack{
                    Text("Name")
                }
                
                ForEach(users.filter({ matchesQuery(str: $0.name) }), id: \.id){ user in
                    HStack {
                        Text(user.name)
                        Text(user.email)
                        Text(user.login)
                        Text(user.studentID)
                    }
                }
            }
        }
        .onAppear(perform: {
            self.users = self.viewModel.getStudentsForCourse(courseId: self.course.id)
        })
        
    }
    
}

struct MembersView_Previews: PreviewProvider {
    static var viewModel = TeacherViewModel(provider: FakeProvider())
    static var previews: some View {
        MembersView(course: viewModel.getCourse(courseId: 111))
    }
}
