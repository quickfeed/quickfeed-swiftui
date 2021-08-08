//
//  StudentGroup.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 02/08/2021.
//

import SwiftUI

struct StudentGroup: View {
    @ObservedObject var viewModel: StudentViewModel
    
    var body: some View {
        Text("NewGroup")
            .font(.title)
            .fontWeight(.bold)
        
    }
}
