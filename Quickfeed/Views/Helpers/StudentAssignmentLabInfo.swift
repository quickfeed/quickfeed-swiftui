//
//  StudentAssignmentLabInfo.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 02/02/2021.
//

import SwiftUI

struct StudentAssignmentLabInfo: View {
    var lab: AssignmentModel
    var status: String
    
    var body: some View {
        VStack{
            HStack{
                Text("Status")
                Spacer()
                if status == "Approved" {
                    Text(status)
                        .foregroundColor(.green)
                }else if status == "Rejected"{
                    Text(status)
                        .foregroundColor(.red)
                }else if status == "Revision"{
                    Text(status)
                        .foregroundColor(.orange)
                }else{
                    Text(status)
                        .foregroundColor(.blue)
                }
            }
            HStack{
                Text("Delivered")
                Spacer()
                Text("\(lab.deadLine)")
            }
            HStack{
                Text("Deadline")
                Spacer()
                Text("\(lab.deadLine)")
            }
            HStack{
                Text("Tests passed")
                Spacer()
                Text("4/4")
            }
            HStack{
                Text("Execution time")
                Spacer()
                Text("10.21 seconds")
            }
            HStack{
                Text("Slip days")
                Spacer()
                Text("7")
            }
        }
    }
}

struct StudentAssignmentLabInfo_Previews: PreviewProvider {
    static var previews: some View {
        StudentAssignmentLabInfo(lab: AssignmentModel.data[0], status: "None")
    }
}
