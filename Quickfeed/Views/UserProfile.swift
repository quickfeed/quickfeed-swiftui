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
    
    var body: some View {
        HStack{
            if viewModel.remoteImage!.state == RemoteImageLoader.State.failure {
                Image(systemName: "person.fill")
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 100, height: 100)
            } else {
                Image(nsImage: NSImage(data: viewModel.remoteImage!.data)!)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 60, height: 60)
                
            }
            Text(viewModel.user.name)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        HStack{
            VStack{
                Text("Personal Information")
                Text("Name")
                Text("Email")
                Text("StudentID")
            }
            Divider()
            VStack{
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
            }
        }
        //TextField("User name (email address)", text: viewModel.user.name)
    }
}

/*struct UserProfile_Previews: PreviewProvider {
 static var previews: some View {
 UserProfile()
 }
 }*/
