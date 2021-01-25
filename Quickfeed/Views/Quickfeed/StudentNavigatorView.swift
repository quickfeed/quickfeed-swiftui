//
//  StudentNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct StudentNavigatorView: View {
    var student: UserModel
    @State private var selectedCourse = 0
    
    var body: some View {
        VStack(alignment: .leading){
           
            Picker(selection: $selectedCourse, label: Text("Current course")) {
                ForEach(0 ..< student.enrolledIn.count){
                    Text(student.enrolledIn[$0].courseCode)
                        
                        
                    
                }
                
            }
            .pickerStyle(MenuPickerStyle())
            .labelsHidden()
            .padding(.bottom, 5)
            LabMenuView(labs: student.enrolledIn[selectedCourse].labs)
                
        }
    }
}

struct StudentNavigatorView_Previews: PreviewProvider {
    static var student = UserModel.data[0]
    static var previews: some View {
        StudentNavigatorView(student: student)
    }
}
