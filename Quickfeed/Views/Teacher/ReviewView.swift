//
//  ReviewView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewView: View {
   @State private var searchQuery: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text("Review Submissions")
                    .font(.title)
                Spacer()
                SearchBar(query: $searchQuery, placeholder: "Search")
                  .frame(minWidth: 60.0, idealWidth: 200.0, maxWidth: 200.0, minHeight: 24.0, idealHeight: 21.0, maxHeight: 21.0, alignment: .center)
            }
            Text("input: \(searchQuery)")
            Spacer()
            
        }
        .padding()
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
