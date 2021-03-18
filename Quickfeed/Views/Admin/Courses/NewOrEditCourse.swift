//
//  NewOrEditCourse.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 18/03/2021.
//

import SwiftUI

struct NewOrEditCourse: View {
    var course: Course?
    @Binding var editCourse: Bool
    
    var body: some View {
        Text(course != nil ? "Edit \(course!.code)" : "New Course")
            .navigationTitle(course != nil ? "\(course!.code) \(course!.name)" : "New Course")
            .toolbar{
                ToolbarItem(placement: .navigation){
                    Toggle(isOn: $editCourse, label: {
                           Image(systemName: "chevron.backward")
                       })
                    .help("Return to course list")
                }
            }
    }
}

/*struct NewOrEditCourse_Previews: PreviewProvider {
    static var previews: some View {
        NewOrEditCourse()
    }
}*/
