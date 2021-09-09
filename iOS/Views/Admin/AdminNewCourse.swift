//
//  AdminNewCourse.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 09/09/2021.
//

import SwiftUI

struct AdminNewCourse: View {
    @ObservedObject var viewModel: AdminViewModel
    
    @State var organization: String = ""
    @State var isValidOrganization: Bool = false
    
    @State var code: String = ""
    @State var slipDays: UInt32 = 0
    @State var slipDaysArray: [UInt32] = []
    
    @State var name: String = ""
    @State var years: [UInt32] = []
    @State var year: UInt32 = 0
    @State var tags: [String] = ["Spring", "Fall", "Always"]
    @State var tag: String = "Spring"
    
    var body: some View {
        Text("Create New Course at QuickFeed")
            .font(.title)
            .fontWeight(.bold)
            .padding()
        ScrollView{
            VStack(alignment: .leading){
                Text("For each new semester of a course, QuickFeed requires a new GitHub organization. This is to keep the student roster for the different runs of the course separate.")
                Text("")
                Link(destination: URL(string: "https://github.com/account/organizations/new")!, label:{
                    Text("Create an organization for your course. The course organization must allow private repositories.")
                })
                Text("")
                Text("QuickFeed will create a following repository structure for you:")
                Text("""
                    - course-info
                    - assignments
                    - tests
                    """)
                    .padding(.leading)
                Text("")
                Link(destination: URL(string: "https://github.com/autograde/quickfeed/blob/master/doc/teacher.md")!, label:{
                    Text("Please read the documentation for further instructions on how to work with the various repositories.")
                })
                Text("")
            }
            VStack(alignment: .leading){
                Text("GitHub Organization Name:")
                TextField("Enter Organization Name...", text: $organization)
                    .disabled(isValidOrganization)
                    .foregroundColor(isValidOrganization ? .secondary : .primary)
                if !isValidOrganization{
                    Button(action: {isValidOrganization = !isValidOrganization}) {
                        Text("Connect Organization")
                    }
                } else {
                    Divider()
                }
            }
            .padding([.top, .leading, .trailing])
            if isValidOrganization{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Code:")
                        TextField("Enter course code...", text: $code)
                    }
                    Divider()
                    VStack(alignment: .leading){
                        Text("Name:")
                        TextField("Enter course name...", text: $name)
                    }
                    .padding(.top)
                    Divider()
                    VStack(alignment: .leading){
                        Text("SlipDays:")
                        Picker("Enter course slipDays...", selection: $slipDays) {
                            ForEach(slipDaysArray, id: \.self) {
                                Text(String($0))
                            }
                        }
                    }
                    .padding(.top)
                    Divider()
                    VStack(alignment: .leading){
                        Text("Semester:")
                        Picker("Enter course semester...", selection: $tag) {
                            ForEach(tags, id: \.self) {
                                Text(String($0))
                            }
                        }
                    }
                    .padding(.top)
                    Divider()
                    VStack(alignment: .leading){
                        Text("Year:")
                        Picker("Enter course year...", selection: $year) {
                            ForEach(years, id: \.self) {
                                Text(String($0))
                            }
                        }
                    }
                    .padding(.top)
                    Button(action: {
                        isValidOrganization = !isValidOrganization
                        organization = ""
                    }){
                        Text("Create Course")
                    }
                    .padding(.top)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
        }
        .padding(.horizontal)
        .onAppear(perform: {
            var slipDays: [UInt32] = []
            for index in 0...10 {
                slipDays.append(UInt32(index))
            }
            self.slipDaysArray = slipDays
            
            var yearsArray: [UInt32] = []
            let year = Calendar.current.component(.year, from: Date())
            for index in 0...2 {
                yearsArray.append(UInt32(year + index))
            }
            self.years = yearsArray
            self.year = yearsArray[0]
        })
    }
}
