//
//  UserProfile.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 08/03/2021.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var selectedCourse: UInt64
    @State var userName: String = ""
    @State var userEmail: String = ""
    @State var userStudentID: String = ""
    
    var body: some View {
        HStack{
            Text(viewModel.user.name)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        HStack{
            VStack(alignment: .leading){
                Text("User Information")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Text("Name:")
                    .bold()
                TextField("Enter your name...", text: $userName)
                Text("Email:")
                    .bold()
                TextField("Enter your Email...", text: $userEmail)
                Text("StudentID:")
                    .bold()
                TextField("Enter your studentID...", text: $userStudentID)
                Spacer()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            Divider()
            VStack(alignment: .leading){
                Text("Enrollments")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                ForEach(viewModel.enrollments!, id: \.self){ enrollment in
                    HStack{
                        Text(viewModel.getCourse(courseId: enrollment.courseID).code)
                        Text(viewModel.getCourse(courseId: enrollment.courseID).name)
                        Text("\(enrollment.courseID)")
                        Text("\(enrollment.totalApproved)")
                        Text("\(enrollment.status.rawValue)")
                        Spacer()
                    }
                    .onTapGesture {
                        self.selectedCourse = enrollment.courseID
                    }
                }
                Spacer()
            }
        }
        .onAppear(perform: {
            self.userName = viewModel.user.name
            self.userEmail = viewModel.user.email
            self.userStudentID = viewModel.user.studentID
        })
        //TextField("User name (email address)", text: viewModel.user.name)
    }
}

/*struct UserProfile_Previews: PreviewProvider {
 static var previews: some View {
 UserProfile()
 }
 }*/
