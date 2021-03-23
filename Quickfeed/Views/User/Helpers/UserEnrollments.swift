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
    @State private var showingAlert = false
    
    func sortedEnrollments() -> [Enrollment] {
        var enrollments = viewModel.enrollments!
        enrollments.sort { viewModel.getCourse(courseId: $0.courseID).code < viewModel.getCourse(courseId: $1.courseID).code }
        return enrollments
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Enrollments")
                    .font(.title2)
                    .bold()
                
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        self.showingAlert = !self.showingAlert
                    }
            }
            List{
                ForEach(self.sortedEnrollments(), id: \.self){ enrollment in
                    HStack{
                        Text(viewModel.getCourse(courseId: enrollment.courseID).code)
                            .frame(width: 60, alignment: .leading)
                        Text(viewModel.getCourse(courseId: enrollment.courseID).name)
                        Spacer()
                        Text(translateUserStatus(status: enrollment.status))
                    }
                    .onTapGesture {
                        self.selectedCourse = enrollment.courseID
                    }
                    Divider()
                }
            }
        }
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                }
    }
}

/*struct UserEnrollments_Previews: PreviewProvider {
    static var previews: some View {
        UserEnrollments()
    }
}*/
