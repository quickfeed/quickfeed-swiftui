//
//  ReviewView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewView: View {
    @State private var searchQuery: String = ""
    @State var users: [User]
    @Binding var selectedLab: UInt64
    @EnvironmentObject var viewModel: TeacherViewModel
    
    
    func matchesQuery(str: String) -> Bool{
        if searchQuery != "" && !str.lowercased().contains(self.searchQuery.lowercased()){
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Review Submissions")
                    .font(.headline)
                LabPicker(labs: viewModel.courses[0].assignments, selectedLab: $selectedLab)
                    .frame(width: 200)
                SearchFieldRepresentable(query: $searchQuery)
                    
                
                    List{
                        
                        Section{
                            ForEach(users, id: \.id){ user in
                                NavigationLink(destination: Text(user.name)){
                                    Text(user.name)
                                }
                            }
                        }
                        
                        Section(header: Text("Students")){
                            if matchesQuery(str: "student1"){
                                NavigationLink(destination: Text("go back")){
                                    Text("student1")
                                }
                            }
                            
                            NavigationLink(destination: Text("go back")){
                                Text("student2")
                            }
                            NavigationLink(destination: Text("go back")){
                                Text("student3")
                            }
                            NavigationLink(destination: Text("go back")){
                                Text("student4")
                            }
                            
                        }
                        
                        Section(header: Text("Groups")){
                            NavigationLink(destination: Text("go back")){
                                Text("group1")
                            }
                            NavigationLink(destination: Text("go back")){
                                Text("group2")
                            }
                            NavigationLink(destination: Text("go back")){
                                Text("group3")
                            }
                            NavigationLink(destination: Text("go back")){
                                Text("group4")
                            }
                            
                        }
                        
                    
                    }
                    
                }
            .padding(5)
                
           
        }
        
        
        
       
            
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(users: [], selectedLab: .constant(1))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
