//
//  LabSection.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/02/2021.
//

import SwiftUI

struct LabSection: View {
    var labs: [Assignment]
    var isTeacher: Bool
    
    var body: some View {
        Section(header: Text("Labs")){
            ForEach(labs, id: \.id){ lab in
                if isTeacher{
                    NavigationLink(destination: Text("Teacher " + lab.name)){
                        Text(lab.name)
                        if lab.isGroupLab {
                            Image(systemName: "person.3.fill")
                        }
                    }
                } else {
                    NavigationLink(destination: Text("Not Teacher " + lab.name)){
                        Text(lab.name)
                        if lab.isGroupLab {
                            Image(systemName: "person.3.fill")
                        }
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
            LabSection(labs: provider.getAssignments(courseID: 111), isTeacher: true)
        }
    }
}
