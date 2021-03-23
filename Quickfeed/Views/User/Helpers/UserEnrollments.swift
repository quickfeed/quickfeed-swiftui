//
//  UserEnrollments.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/03/2021.
//

import SwiftUI

struct UserEnrollments: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var selectedCourse: UInt64
    
    var body: some View {
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
}

/*struct UserEnrollments_Previews: PreviewProvider {
    static var previews: some View {
        UserEnrollments()
    }
}*/
