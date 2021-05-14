//
//  SearchToggleToolbarItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 14/05/2021.
//

import SwiftUI

struct SearchToggleToolbarItem: View {
    @Binding var isSearching: Bool
    var body: some View {
        if isSearching{
            Button(action: {
                isSearching = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isSearching = true
                }
            }, label: {
            })
            .keyboardShortcut("f")
            .labelsHidden()
        }
    }
}

