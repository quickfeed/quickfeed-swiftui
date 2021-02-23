//
//  SearchFieldController.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 09/02/2021.
//

import SwiftUI
import AppKit

class SearchFieldController: NSViewController {
    
    @Binding var query: String
    
    
    init(query: Binding<String>) {
        self._query = query
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let searchField = NSSearchField()
        searchField.delegate = self
        
        self.view = searchField
    }
    
    
}


extension SearchFieldController: NSSearchFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            self.query = textField.stringValue
        }
    }
}
