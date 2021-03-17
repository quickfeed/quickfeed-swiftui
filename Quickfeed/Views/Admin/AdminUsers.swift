//
//  AdminUsers.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import SwiftUI

struct AdminUsers: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var searchQuery: String = ""
    @Binding var showUsers: Bool
    
    
    func filteredUsers() -> [User] {
        return viewModel.users!.filter({ matchesQuery(user: $0) })
    }
    
    var body: some View {
        List{
            Section(header: HStack{
                Text("Name")
                    .frame(width: 200, alignment: .leading)
                Spacer()
                Text("Email")
                    .frame(width: 200, alignment: .leading)
                Spacer()
                Text("StudentID")
                    .frame(width: 60, alignment: .leading)
                Spacer()
                Text("IsAdmin")
                    .frame(width: 60, alignment: .trailing)
            }){
                ForEach(self.filteredUsers(), id: \.self){ user in
                    HStack{
                        Link(destination: URL(string: "https://www.github.com/" + user.login)!, label:{
                            Text(user.name)
                                .frame(width: 200, alignment: .leading)
                        })
                        Spacer()
                        Link(destination: URL(string: "mailto:" + user.email)!, label: {
                            Text(user.email)
                                .frame(width: 200, alignment: .leading)
                        })
                        Spacer()
                        Text(user.studentID)
                            .frame(width: 60, alignment: .leading)
                        Spacer()
                        Text(user.isAdmin ? "Admin" : "Student")
                            .frame(width: 60, alignment: .trailing)
                    }
                    .onTapGesture {
                        viewModel.updateUser(user: user)
                    }
                    Divider()
                }
            }
        }
        .navigationTitle("Manage Users")
        .toolbar{
            Button(action: {self.showUsers = false}, label: {
                Text("Courses")
            })
            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
        
    }
    
    func matchesQuery(user: User) -> Bool{
        if searchQuery == ""{
            return true
        }
        
        if  user.name.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if  user.email.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if user.studentID.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        if user.login.lowercased().contains(self.searchQuery.lowercased()){
            return true
        }
        
        
        return false
    }
}
/*struct AdminUsers_Previews: PreviewProvider {
    static var previews: some View {
        AdminUsers()
    }
}*/
