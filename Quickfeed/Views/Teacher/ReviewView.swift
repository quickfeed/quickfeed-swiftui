//
//  ReviewView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct ReviewView: View {
   @State private var searchString: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Review Submissions")
                .font(.title)
            HStack{
                SearchBar(searchString: $searchString)
            }
            Text("input: \(searchString)")
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
