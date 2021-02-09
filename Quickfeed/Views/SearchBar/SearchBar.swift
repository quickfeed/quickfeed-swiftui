//
//  SearchBar.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//


import SwiftUI



// NOTE: This extension removes the focus ring entirely.
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

struct SearchBar: View {
    @Binding var query: String
    @State var isFocused: Bool = false
    var placeholder: String = "Search for students and groups..."
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(.windowBackgroundColor))
            .frame(width: 200, height: 22)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(isFocused ? Color.blue.opacity(0.7) : Color.gray.opacity(0.4), lineWidth: isFocused ? 3 : 1)
                        .frame(width: 200, height: 21)
            )

            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:12, height: 12)
                    .padding(.leading, 5)
                    .opacity(0.8)
                TextField(placeholder, text: $query, onEditingChanged: { (editingChanged) in
                    if editingChanged {
                            self.isFocused = true
                        
                    } else {
                        self.isFocused = false
                    }
                })
                    .textFieldStyle(PlainTextFieldStyle())
                if query != "" {
                    Button(action: {
                        
                        self.query = ""
                            
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:14, height: 14)
                            .padding(.trailing, 3)
                            .opacity(0.5)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(self.query == "" ? 0 : 0.5)
                }
            }

        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant(""), placeholder: "Search")
          .frame(minWidth: 60.0, idealWidth: 200.0, maxWidth: 200.0, minHeight: 24.0, idealHeight: 21.0, maxHeight: 21.0, alignment: .center)
        
        SearchBar(query: .constant(""), placeholder: "Search")
          .frame(minWidth: 60.0, idealWidth: 200.0, maxWidth: 200.0, minHeight: 24.0, idealHeight: 21.0, maxHeight: 21.0, alignment: .center)
            .preferredColorScheme(.light)
    }
}
