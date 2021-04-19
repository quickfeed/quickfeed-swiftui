//
//  LabPicker.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 09/02/2021.
//

import SwiftUI

struct LabPicker: View {
    var labs: [Assignment]
    @Binding var selectedLab: UInt64
    var body: some View {
        Picker(selection: $selectedLab, label: Text("Selected lab")) {
            ForEach(labs, id: \.id){ lab in
                Text(lab.name)
            }
        }
        .labelsHidden()
        .pickerStyle(MenuPickerStyle())
        
    }
}

