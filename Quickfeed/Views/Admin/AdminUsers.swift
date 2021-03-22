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
        var users = viewModel.users!
        users.sort {
            if $0.isAdmin != $1.isAdmin{
                return $0.isAdmin && !$1.isAdmin
            } else {
                return $0.name.trimmingCharacters(in: .whitespacesAndNewlines) < $1.name.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        return users.filter({ matchesQuery(searchQuery: searchQuery, user: $0) })
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
                    .frame(width: 80, alignment: .leading)
            }, content: {
                ForEach(self.filteredUsers(), id: \.self){ user in
                    HStack{
                        Link(destination: URL(string: "https://www.github.com/" + user.login)!, label:{
                            Text(user.name != "" ? user.name : user.login)
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
                        Button(action: {
                            viewModel.updateUser(user: user)
                        }, label: {
                            Text(user.isAdmin ? "Demote" : "Promote")
                        })
                        .foregroundColor(user.isAdmin ? .red : .blue)
                        .frame(width: 80)
                        .padding(.leading)
                        .disabled(user.id == viewModel.user.id)
                        
                    }
                    Divider()
                }
            })
        }
        .background(Color.clear)
        .navigationTitle("Manage Users")
        .toolbar{
            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}
/*struct AdminUsers_Previews: PreviewProvider {
 static var previews: some View {
 AdminUsers()
 }
 }*/
