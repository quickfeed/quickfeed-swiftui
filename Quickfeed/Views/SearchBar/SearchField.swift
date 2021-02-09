//
//  SearchField.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 09/02/2021.
//

import SwiftUI
import AppKit

struct SearchFieldRepresentable: NSViewControllerRepresentable {
    @Binding var query: String
    
    func makeNSViewController(
        context: NSViewControllerRepresentableContext<SearchFieldRepresentable>
    ) -> SearchFieldController {
        return SearchFieldController(query: $query)
    }
    
    func updateNSViewController(
        _ nsViewController: SearchFieldController,
        context: NSViewControllerRepresentableContext<SearchFieldRepresentable>
    ) {
    }
    
    
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldRepresentable(query: .constant("test"))
        
        SearchFieldRepresentable(query: .constant("test"))
            .preferredColorScheme(.light)
    }
}
