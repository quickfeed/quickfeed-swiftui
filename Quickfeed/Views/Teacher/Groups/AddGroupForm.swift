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
    @State var addGroupErr: String? = nil
    
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
        group.status = .pending
        let err = viewModel.createGroup(group: group)
        
        if err == nil{
            resetState()
        } else{
            addGroupErr = err
        }
        
    
    }
    
    var body: some View {
        VStack{
            SelectedMembers(selectedMembers: $selectedMembers, groupCreator: nil)
            Divider()
            HStack{
                Text("Name:")
                    .frame(width: 75, alignment: .leading)
                Spacer()
                TextField("Enter group name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {createGroup()}, label: {
                    Text("Create group")
                })
                .disabled(selectedMembers.count > 0 && groupName != "" ? false : true)
            }
            if addGroupErr != nil{
                Text(addGroupErr!)
            }
            Divider()
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
