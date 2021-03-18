//
//  AdminCourses.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import SwiftUI

struct AdminCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var searchQuery: String = ""
    @Binding var showUsers: Bool
    
    func filteredCourse() -> [Course] {
        return viewModel.courses!.filter({ matchesQuery(searchQuery: searchQuery, course: $0) })
    }
    
    var body: some View {
        List{
            Section(header: HStack{
                Text("Course Code")
                    .frame(width: 120, alignment: .leading)
                Text("Course Name")
                    .frame(width: 300, alignment: .leading)
                Spacer()
                Text("Semester")
                    .frame(width: 60, alignment: .leading)
                Text("Years")
                    .frame(width: 60, alignment: .leading)
                Divider()
                Text("Edit")
                    .frame(width: 60, alignment: .leading)
            }){
                ForEach(self.filteredCourse(), id: \.self){ course in
                    HStack{
                        Link(destination: URL(string: "https://www.github.com/" + course.organizationPath)!, label:{
                            Text(course.code)
                                .frame(width: 120, alignment: .leading)
                        })
                        Text(course.name)
                            .frame(width: 300, alignment: .leading)
                        Spacer()
                        Text(course.tag)
                            .frame(width: 60, alignment: .leading)
                        Text("\(String(course.year))")
                            .frame(width: 60, alignment: .leading)
                        Divider()
                        Button(action: {print("Hello, World!")}, label: {
                            Text("Edit")
                        })
                        .frame(width: 60)
                    }
                    Divider()
                }
            }
        }
        .navigationTitle("Manage Courses")
        .toolbar{
            Button(action: {self.showUsers = true}, label: {
                Text("Users")
            })
            Image(systemName: "plus")
                .help("Create New Course")
                .imageScale(.large)
            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}

/*struct AdminCourses_Previews: PreviewProvider {
    static var previews: some View {
        AdminCourses()
    }
}*/
