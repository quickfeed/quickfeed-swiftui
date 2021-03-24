
//
//  ReleaseNavigationView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 05/03/2021.
//

import SwiftUI

struct ReleaseNavigationView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State private var searchQuery: String = ""
    @Binding var selectedLab: UInt64
    @State private var showCompleted: Bool = true
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){

                
            }
            .padding()
        }
        .navigationTitle("Release Submissions")
        .navigationSubtitle(viewModel.currentCourse.name)
        .toolbar{
            LabPicker(labs: viewModel.manuallyGradedAssignments, selectedLab: $selectedLab)

            SearchFieldRepresentable(query: $searchQuery)
                .frame(minWidth: 200, maxWidth: 350)
        }
    }
}

struct ReleaseNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseNavigationView(viewModel: TeacherViewModel(provider: FakeProvider(), course: Course()), selectedLab: .constant(1))
    }
}
