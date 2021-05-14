//
//  SearchField.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 09/02/2021.
//

import SwiftUI
import AppKit

struct SearchField: NSViewControllerRepresentable {
    @Binding var query: String
    
    func makeNSViewController(
        context: NSViewControllerRepresentableContext<SearchField>
    ) -> SearchFieldController {
        return SearchFieldController(query: $query)
    }
    
    func updateNSViewController(
        _ nsViewController: SearchFieldController,
        context: NSViewControllerRepresentableContext<SearchField>
    ) {
    }
}



struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(query: .constant("test"))
        
        SearchField(query: .constant("test"))
            .preferredColorScheme(.light)
    }
}
