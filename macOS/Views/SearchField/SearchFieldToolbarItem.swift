//
//  SearchFieldToolbarItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 14/05/2021.
//

import SwiftUI

struct SearchFieldToolbarItem: View {
    @Binding var isSearching: Bool
    @Binding var searchQuery: String
    var body: some View {
        if !isSearching{
            Toggle(isOn: $isSearching, label: {
                Image(systemName: "magnifyingglass")
            })
            .keyboardShortcut("f")
        } else {
            SearchField(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}

