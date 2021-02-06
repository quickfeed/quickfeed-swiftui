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
                
                CourseSelectorView(courses: viewModel.courses, selectedCourse: $selectedCourse)
                
            .padding(.horizontal)
            .pickerStyle(MenuPickerStyle())
            .labelsHidden()
            TabView {
                VStack{
                    LabListView()
                    
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
        
    }
    
}


struct TeacherNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherNavigatorView(viewModel: TeacherViewModel(provider: FakeProvider()), selectedCourse: .constant(111))
    }
}
