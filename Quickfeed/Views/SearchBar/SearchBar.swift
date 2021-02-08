//
//  SearchBar.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI


struct SearchBar: View {
    @Binding var searchString: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for students and groups", text: $searchString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accentColor(.none)
                .onChange(of: searchString, perform: { value in
                    isEditing = true
                })
            if isEditing{
                Image(systemName: "multiply.circle.fill")
            }
                
           
        }
        .padding(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchString: .constant(""))
        
        SearchBar(searchString: .constant(""))
            .preferredColorScheme(.light)
    }
}
