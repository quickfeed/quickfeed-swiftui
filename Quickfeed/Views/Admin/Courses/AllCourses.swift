//
//  AllCourses.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 18/03/2021.
//

import SwiftUI

struct AllCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var searchQuery: String = ""
    @Binding var showUsers: Bool
    @Binding var editCourse: Bool
    @Binding var course: Course?
    
    func filteredCourse() -> [Course] {
        var courses = viewModel.courses!
        courses.sort { $0.code < $1.code }
        return courses.filter({ matchesQuery(searchQuery: searchQuery, course: $0) })
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
                    .frame(width: 120, alignment: .leading)
                Text("Years")
                    .frame(width: 80, alignment: .leading)
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
                            .frame(width: 120, alignment: .leading)
                        Text("\(String(course.year))")
                            .frame(width: 80, alignment: .leading)
                        Divider()
                        Button(action: {
                            self.course = course
                            self.editCourse = !self.editCourse
                        }, label: {
                            Text("Edit")
                        })
                        .frame(width: 60)
                    }
                    Divider()
                }
            }
        }
        .frame(minWidth: 800, maxWidth: .infinity)
        .navigationTitle("Manage Courses")
        .toolbar{
            Button(action: {
                self.course = nil
                self.editCourse = !self.editCourse
            }, label: {
                Image(systemName: "plus")
            })
            .keyboardShortcut("c")
            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}

/*struct AllCourses_Previews: PreviewProvider {
 static var previews: some View {
 AllCourses()
 }
 }*/
