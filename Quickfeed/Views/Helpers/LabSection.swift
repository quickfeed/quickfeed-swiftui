//
//  LabSection.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct LabSection: View {
    var assignments: [Assignment]
    
    var body: some View {
        Section(header: Text("Labs")){
            ForEach(assignments, id: \.id){ assignment in
                NavigationLink(destination: StudentLab(assignment: assignment, slipdays: UInt32(7))){
                    Text(assignment.name)
                    if assignment.isGroupLab {
                        Image(systemName: "person.3.fill")
                    }
                }
            }
            .padding(.leading)
        }
    }
}

struct LabSection_Previews: PreviewProvider {
    static var previews: some View {
        let provider = FakeProvider()
        List{
            LabSection(assignments: provider.getAssignments(courseID: 111))
        }
    }
}
