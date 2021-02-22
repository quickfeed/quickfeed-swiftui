//
//  TeacherView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI

struct TeacherNavigatorView: View {
    @StateObject var viewModel: TeacherViewModel
    @State var selectedCourse: UInt64
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    .padding(.top)
                    .padding(.horizontal)
                
                List{
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "chart.bar")
                        Text("Results")
                        
                    }
                    NavigationLink(destination: ReviewView()){
                        Image(systemName: "list.dash")
                        Text("Review")
                        
                    }
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "arrow.up.doc.fill")
                        Text("Release")
                        
                    }
                    
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "person.2")
                        Text("Groups")
                        
                    }
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "person")
                        Text("Members")
                        
                    }
                    Spacer()
                    
                    GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: true)
                    
                }
            }
                
        }
        
    }
    
}


struct TeacherNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigatorView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
