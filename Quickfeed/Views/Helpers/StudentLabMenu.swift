//
//  StudentLabMenu.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 02/02/2021.
//

import SwiftUI

struct StudentLabMenu: View {
    var selectedCourse: Int
    var labs: [AssignmentModel]
    
    var body: some View {
        ForEach(labs, id: \.id){ lab in
            if lab.courseId == selectedCourse{
                NavigationLink(destination: StudentLabOverview(lab: lab, side: lab.id, scoreLimit: lab.scoreLimit)){
                    Text(lab.name)
                    Spacer()
                    if lab.isGroupLab {
                        Image(systemName: "person.3.fill")
                    }
                }
            }
        }
    }
}

struct StudentLabMenu_Previews: PreviewProvider {
    static var labs: [AssignmentModel] = AssignmentModel.data
    
    static var previews: some View {
        StudentLabMenu(selectedCourse: 1, labs: labs)
    }
}
