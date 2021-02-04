//
//  TeacherView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import SwiftUI

struct TeacherNavigatorView: View {
    @StateObject var viewModel: TeacherViewModel
    @Binding var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Courses")
                    .padding(.top)
                Picker(selection: $selectedCourse, label: Text("Current course")) {
                    ForEach(viewModel.courses, id: \.id){ course in
                        NavigationLink(destination: Text(course.code)){
                            Text(course.code)
                        }
                    }
                }
                .padding(.horizontal)
                .pickerStyle(MenuPickerStyle())
                .labelsHidden()
                TabView {
                    VStack{
                        Text("Labs for \(viewModel.getCourse(courseId: selectedCourse).code)")
                        
                        Spacer()
                    }
                        .tabItem {
                            Image(systemName: "1.square.fill")
                            Text("Labs")
                        }
                    VStack{
                        Text("Students")
                        
                        Spacer()
                    }
                
                        .tabItem {
                            Image(systemName: "2.square.fill")
                            Text("Students")
                        }
                    
                }
                .font(.headline)
                
            }
            
        }
        .onAppear()
    }
}

struct TeacherNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigatorView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: .constant(111))
    }
}
