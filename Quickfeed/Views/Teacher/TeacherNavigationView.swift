//
//  TeacherNavigationView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI

struct TeacherNavigationView: View {
    @StateObject var viewModel: TeacherViewModel
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack{
                CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    .padding(.top)
                    .padding(.horizontal)
                
                List{
                    NavigationLink(destination: Text("Results")){
                        Image(systemName: "chart.bar")
                            .frame(width: 20)
                        Text("Results")
                            
                        
                    }
                    NavigationLink(destination: ReviewView()){
                        Image(systemName: "list.dash")
                            .frame(width: 20)
                        Text("Review")
                    }
                    NavigationLink(destination: Text("Release")){
                        Image(systemName: "arrow.up.doc.fill")
                            .frame(width: 20)
                        Text("Release")
                    }
                    
                    NavigationLink(destination: Text("Groups")){
                        Image(systemName: "person.2")
                            .frame(width: 20)
                        Text("Groups")
                    }
                    NavigationLink(destination: Text("Test")){
                        Image(systemName: "person")
                            .frame(width: 20)
                        Text("Members")
                    }
                    Spacer()
                    GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: true)
                    
                }
            }
                
        }
        
    }
    
}


struct TeacherNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigationView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
