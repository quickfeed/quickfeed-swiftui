//
//  AdminCourseProfile.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 09/09/2021.
//

import SwiftUI

struct AdminCourseProfile: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var course: Course
    @State var isEdit: Bool = false
    
    var body: some View {
        if isEdit {
            EditCourse(viewModel: viewModel, isEdit: $isEdit, course: course)
        } else {
            CourseProfile(viewModel: viewModel, isEdit: $isEdit, course: course)
        }
    }
}

struct CourseProfile: View {
    @ObservedObject var viewModel: AdminViewModel
    @Binding var isEdit: Bool
    @State var course: Course
    
    var body: some View {
        VStack{
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                VStack{
                    HStack{
                        Text("Code:")
                        Spacer()
                        Link(destination: URL(string: "https://www.github.com/" + course.organizationPath)!, label:{
                            Text(course.code)
                        })
                    }
                    .padding(.top)
                    Divider()
                    HStack{
                        Text("SlipDays:")
                        Spacer()
                        Text(String(course.slipDays))
                    }
                    .padding(.top)
                    Divider()
                    HStack{
                        Text("Semester:")
                        Spacer()
                        Text(course.tag)
                    }
                    .padding(.top)
                    Divider()
                    HStack{
                        Text("Year:")
                        Spacer()
                        Text(String(course.year))
                    }
                    .padding(.top)
                }
                .padding()
            }
            Spacer()
        }
        .padding(.horizontal)
        .toolbar {
            Button(action: {
                isEdit = !isEdit
            }){
                Text("Edit")
            }
            
        }
    }
}

struct EditCourse: View {
    @ObservedObject var viewModel: AdminViewModel
    @Binding var isEdit: Bool
    @State var course: Course
    
    @State var code: String = ""
    @State var slipDays: UInt32 = 0
    @State var slipDaysArray: [UInt32] = []
    
    @State var name: String = ""
    @State var years: [UInt32] = []
    @State var year: UInt32 = 0
    @State var tags: [String] = ["Spring", "Fall", "Always"]
    @State var tag: String = "Spring"
    
    var body: some View {
        VStack{
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Code:")
                        TextField("Enter course code...", text: $code)
                    }
                    .padding(.top)
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
                        viewModel.updateCourse(course: course, name: name, code: code, year: year, tag: tag, slipDays: slipDays)
                        isEdit = !isEdit
                    }){
                        Text("Update Course")
                    }
                    .padding(.top)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            Spacer()
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
            if yearsArray.contains(course.year){
                self.year = course.year
            }else{
                self.year = yearsArray[0]
            }
            
            self.code = course.code
            self.name = course.name
            self.slipDays = course.slipDays
            
            if course.tag.lowercased() == "spring" {
                self.tag = "Spring"
            } else if course.tag.lowercased() == "fall" {
                self.tag = "Fall"
            } else {
                self.tag = "Always"
            }
        })
    }
}

