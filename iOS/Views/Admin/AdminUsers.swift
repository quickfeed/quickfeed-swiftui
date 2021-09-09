//
//  AdminUsers.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 09/09/2021.
//

import SwiftUI

struct AdminUsers: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var searchQuery: String = ""
    
    func filteredUsers() -> [User] {
        var users = viewModel.users
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
        NavigationView{
            Form{
                Section(header: Text("Search")){
                    TextField("Enter User...", text: $searchQuery)
                }
                Section(header: Text("Admin")){
                    List{
                        ForEach(self.filteredUsers(), id: \.self){ user in
                            if user.isAdmin{
                                NavigationLink(destination: Text(user.name)){
                                    Text(user.name != "" ? user.name : user.login)
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Users")){
                    List{
                        ForEach(self.filteredUsers(), id: \.self){ user in
                            if !user.isAdmin && user.name != ""{
                                NavigationLink(destination: Text(user.name)){
                                    Text(user.name)
                                }
                            }
                        }
                    }
                }
                Section(header: Text("New Users")){
                    List{
                        ForEach(self.filteredUsers(), id: \.self){ user in
                            if user.name == "" {
                                Text(user.login)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Manage Users")
        }
    }
}
