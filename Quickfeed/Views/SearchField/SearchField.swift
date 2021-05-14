//
//  SearchField.swift
//  Quickfeed
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
