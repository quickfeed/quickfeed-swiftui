//
//  ReviewView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewView: View {
    @State private var searchQuery: String = ""
    @Binding var selectedLab: UInt64
    @EnvironmentObject var viewModel: TeacherViewModel
    

    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
                Text("Review Submissions")
                    .navigationTitle("navigation")
                LabPicker(labs: viewModel.courses[0].assignments, selectedLab: $selectedLab)
                    .frame(width: 200)
                SearchFieldRepresentable(query: $searchQuery)
                    .frame(width: 200, height: 20)
                    
                Text("input: \(searchQuery)")
                Text("count: \(viewModel.courses[0].assignments.count)")
                Spacer()
                
                    List{
                        Section(header: Text("Students")){
                            NavigationLink(destination: Text("back")){
                                Text("student1")
                            }
                            .navigationTitle("Test")
                            
                        }
                    }
                    
                }
                
           
        }
        
        
        
       
            
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(selectedLab: .constant(1))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
