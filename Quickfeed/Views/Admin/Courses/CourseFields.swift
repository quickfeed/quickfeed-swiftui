//
//  CourseFields.swift
//  Quickfeed
//

import SwiftUI

struct CourseFields: View {
    @ObservedObject var viewModel: AdminViewModel
    var course: Course?
    @State var code: String = ""
    @State var name: String = ""
    @State var years: [String] = []
    @State var year: String = "2022"
    @State var slipDays: UInt32 = 0
    @State var slipDaysArray: [UInt32] = []
    @State var tags: [String] = ["Spring", "Fall", "Always"]
    @State var tag: String = "Spring"
    
    var body: some View {
        Text("Course Code:")
            .bold()
        TextField("Enter course code...", text: $code)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 400)
            .padding(.leading)
        Text("Course Name:")
            .bold()
        TextField("Enter course name...", text: $name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 400)
            .padding(.leading)
        CourseFieldPickers(name: "Semester", list: tags, value: $tag)
        CourseFieldPickers(name: "Year", list: years, value: $year)
        Text("SlipDays:")
            .bold()
        Picker("Enter course tag...", selection: $slipDays) {
            ForEach(slipDaysArray, id: \.self) {
                Text(String($0))
            }
        }
        .frame(width: 400)
        .labelsHidden()
        .padding(.leading)
        if code != "" && name != "" {
            Button(action: {
                if course == nil {
                    viewModel.createCourse(name: name, code: code, year: year, tag: tag, slipDays: slipDays)
                }else{
                    viewModel.updateCourse(course: course!, name: name, code: code, year: year, tag: tag, slipDays: slipDays)
                }
            }, label: {
                Text(course == nil ? "Create" : "Edit")
            })
        }
        Spacer()
        .onAppear(perform: {
            var slipDays: [UInt32] = []
            for index in 0...20 {
                slipDays.append(UInt32(index))
            }
            self.slipDaysArray = slipDays
            var yearsArray: [String] = []
            let year = Calendar.current.component(.year, from: Date())
            for index in 0...2 {
                yearsArray.append(String(year + index))
            }
            self.years = yearsArray
            self.year = yearsArray[0]
            if course != nil {
                self.code = course!.code
                self.name = course!.name
                self.slipDays = course!.slipDays
                if course!.tag.lowercased() == "spring" {
                    self.tag = "Spring"
                } else if course!.tag.lowercased() == "fall" {
                    self.tag = "Fall"
                } else {
                    self.tag = "Always"
                }
                if yearsArray.contains(String(course!.year)){
                    self.year = String(course!.year)
                }
            }
        })
    }
}

struct CourseFieldPickers: View {
    var name: String
    var list: [String]
    @Binding var value: String
    
    var body: some View {
        Text("\(name):")
            .bold()
        Picker("Enter course \(name)...", selection: $value) {
            ForEach(list, id: \.self) {
                Text($0)
            }
        }
        .frame(width: 400)
        .labelsHidden()
        .padding(.leading)
    }
}

