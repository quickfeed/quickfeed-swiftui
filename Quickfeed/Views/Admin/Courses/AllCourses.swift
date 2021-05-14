//
//  AllCourses.swift
//  Quickfeed
//

import SwiftUI

struct AllCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    @Binding var course: Course?
    @State var searchQuery: String = ""
    @Binding var editCourse: Bool
    
    var body: some View {
        List{
            Section(header: HStack{
                Text("Course Code")
                    .frame(width: 120, alignment: .leading)
                Text("Course Name")
                    .frame(width: 300, alignment: .leading)
                Spacer()
                Text("SlipDays")
                    .frame(width: 120, alignment: .leading)
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
                        Text(String(course.slipDays))
                            .frame(width: 120, alignment: .leading)
                        Text(course.tag)
                            .frame(width: 120, alignment: .leading)
                        Text("\(String(course.year))")
                            .frame(width: 80, alignment: .leading)
                        Divider()
                        Image(systemName: "square.and.pencil")
                            .frame(width: 60)
                            .onTapGesture {
                                self.course = course
                                self.editCourse = !self.editCourse
                            }
                            .help("Edit \(course.code)")
                    }
                    Divider()
                }
            }
        }
        .frame(minWidth: 920, maxWidth: .infinity, minHeight: 100)
        .navigationTitle("Manage Courses")
        .toolbar{
            Button(action: {
                self.course = nil
                self.editCourse = !self.editCourse
            }, label: {
                Image(systemName: "plus")
            })
            .help("Create New Course")
            SearchField(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
    
    func filteredCourse() -> [Course] {
        var courses = viewModel.courses!
        courses.sort { $0.code < $1.code }
        return courses.filter({ matchesQuery(searchQuery: searchQuery, course: $0) })
    }
}
