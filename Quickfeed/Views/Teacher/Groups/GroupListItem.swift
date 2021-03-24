//
//  GroupListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/03/2021.
//

import SwiftUI

struct GroupListItem: View {
    var group: Group
    @Binding var isEditing: Bool
    var body: some View {
        HStack{
            Text(group.name)
                .frame(width: 200, alignment: .leading)
            Spacer()
            VStack(alignment: .leading){
                ForEach(group.enrollments, id: \.self){ enrollment in
                    Text(enrollment.user.name)
                }
            }
            .frame(width: 200, alignment: .leading)
            
            Spacer()
            if isEditing{
                VStack{
                    if group.status != .approved{
                        Button(action: {}, label: {
                            Text("Approve")
                                .frame(width: 60)
                                .foregroundColor(Color.green)
                        })
                    } else{
                        Button(action: {}, label: {
                            Text("Approved")
                                .frame(width: 60)
                        })
                        .disabled(true)
                    }
                    Button(action: {}, label: {
                        Text("Delete")
                            .frame(width: 60)
                            .foregroundColor(Color.red)
                    })
                    
                }
                .frame(width: 80, alignment: .leading)
                
            } else{
                Text("\(group.status.rawValue == 1 ? "Approved" : "Pending" )")
                    .frame(width: 75, alignment: .leading)
            }
            
        }
        
    }
}

