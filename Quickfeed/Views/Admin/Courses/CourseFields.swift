//
//  CourseFields.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/04/2021.
//

import SwiftUI

struct CourseFields: View {
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
        Text("Semester:")
            .bold()
        Picker("Enter course tag...", selection: $tag) {
            ForEach(tags, id: \.self) {
                Text($0)
            }
        }
        .frame(width: 400)
        .labelsHidden()
        .padding(.leading)
        Text("Year:")
            .bold()
        Picker("Enter course tag...", selection: $year) {
            ForEach(years, id: \.self) {
                Text($0)
            }
        }
        .frame(width: 400)
        .labelsHidden()
        .padding(.leading)
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
        .onAppear(perform: {
            var slipDays: [UInt32] = []
            for index in 0...20 {
                slipDays.append(UInt32(index))
            }
            self.slipDaysArray = slipDays
            let year = Calendar.current.component(.year, from: Date())
            var yearsArray: [String] = []
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
