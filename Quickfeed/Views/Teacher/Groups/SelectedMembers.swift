//
//  SelectedMembers.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/03/2021.
//

import SwiftUI

struct SelectedMembers: View {
    @Binding var selectedMembers: [Enrollment]
    var groupCreator: User? // Used in student accessible groupForm
    
    var body: some View {
        HStack{
            Text("Members:")
                .frame(width: 75, height: 16, alignment: .leading)
            Spacer()
            HStack{
                if groupCreator != nil{
                    HStack{
                        Text((groupCreator?.name)!)
                    }
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color(.selectedTextBackgroundColor)))
                    
                }
                ForEach(selectedMembers, id: \.self){ enrollment in
                    HStack{
                        
                        Text(enrollment.user.name)
                            .frame(height: 16, alignment: .leading)
                            .help(enrollment.user.name)
                        Button(action: {selectedMembers.removeAll(where: {$0.user.id == enrollment.user.id})}, label: {
                            Image(systemName: "multiply.circle")
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color(.selectedTextBackgroundColor)))
                }
 
            }
            .frame(height: 20)
        }
    }
}
