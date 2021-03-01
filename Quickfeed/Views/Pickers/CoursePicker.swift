//
//  CourseSelectorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/02/2021.
//

import SwiftUI

struct CoursePicker: View {
    var courses: [Course]
    @Binding var selectedCourse: UInt64
    
    var body: some View {
        Picker(selection: $selectedCourse, label: Text("Current course")) {
            ForEach(courses, id: \.id){ course in
                Text(course.code)
            }
        }
        .labelsHidden()
        .pickerStyle(MenuPickerStyle())
        
    }
}

struct CourseSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let provider = FakeProvider()
        CoursePicker(courses: provider.getCourses(), selectedCourse: .constant(111))
    }
}
