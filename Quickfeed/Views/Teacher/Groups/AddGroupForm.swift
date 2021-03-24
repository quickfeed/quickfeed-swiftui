//
//  AddGroupForm.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/03/2021.
//

import SwiftUI

struct AddGroupForm: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var groupName: String = ""
    @State var searchQuery: String = ""
    @State var selectedMembers: [Enrollment] = []
    
     var availableStudents: [Enrollment] {
        return viewModel.enrollments.filter({
            for enr in selectedMembers{
                if enr.user.id == $0.user.id{
                    return false
                }
            }
            return true
        })
    }
    
    func resetState(){
        self.selectedMembers = []
        self.groupName = ""
        self.searchQuery = ""
    }
    
    
    func createGroup(){
        var group = Group()
        group.courseID = viewModel.currentCourse.id
        group.users = []
        for enr in selectedMembers{
            var user = User()
            user.id = enr.user.id
            group.users.append(user)
        }
        group.name = groupName
        group.status = .approved
        _ = viewModel.createGroup(group: group)
        resetState()
    }
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Name:")
                    Spacer()
                    TextField("Enter group name", text: $groupName)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                }
                Divider()
                HStack{
                    Text("Members:")
                    Spacer()
                    ForEach(selectedMembers, id: \.self){ enrollment in
                        HStack{
                            Text(enrollment.user.name)
                            Button(action: {}, label: {
                                Image(systemName: "multiply.circle")
                            })
                            .buttonStyle(PlainButtonStyle())
                        }
                            .padding(4)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color(.selectedTextBackgroundColor)))
                    }
                    .animation(.easeIn)
                }
                Divider()
                
                
                
            }
            
            VStack{
                
                List{
                    Section(header: Text("Available students")){
                        ForEach(availableStudents, id: \.self){ enrollment in
                            HStack{
                                Text(enrollment.user.name)
                                Spacer()
                                Button(action: {selectedMembers.append(enrollment)}, label: {
                                    Image(systemName: "plus.circle")
                                })
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                            Divider()
                            
                        }
                    }
                }
                
            }
                        
            Button(action: {createGroup()}, label: {
                Text("Create group")
            })
            
            
            
            
            Spacer()
        }
        .onAppear(perform:{
            viewModel.loadEnrollments()
        })
        .navigationTitle("Add Group")
        .navigationSubtitle(viewModel.currentCourse.name)
        .toolbar{
            ToolbarItem{
                SearchFieldRepresentable(query: $searchQuery)
                    .frame(minWidth: 200, maxWidth: 350)
            }
        }
        .padding()
    }
}

struct AddGroupForm_Previews: PreviewProvider {
    static var previews: some View {
        AddGroupForm(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()))
    }
}
