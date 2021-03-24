//
//  MemberListItem.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 22/02/2021.
//

import SwiftUI

struct MemberListItem: View {
    @ObservedObject var viewModel: TeacherViewModel
    var enrollment: Enrollment
    @Binding var isEditing: Bool
    
    func acceptUser(){
        viewModel.changeUserStatus(enrollment: enrollment, status: .student)
    }
    
    var body: some View {
        HStack {
            SwiftUI.Group{
                Link(destination: URL(string: "https://www.github.com/" + viewModel.currentCourse.organizationPath + "/" + enrollment.user.login + "-labs")!, label:{
                    Text(enrollment.user.name)
                        .frame(width: 180, alignment: .leading)
                })
                Spacer()
                
            }
            SwiftUI.Group{
                Text(enrollment.user.studentID)
                    .frame(width: 60, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Link(destination: URL(string: "mailto:" + enrollment.user.email)!, label: {
                    Text(enrollment.user.email)
                        .frame(width: 200, alignment: .leading)
                })
                
                Spacer()
                
            }
            
            SwiftUI.Group{
                Text("\(enrollment.lastActivityDate != "" ? enrollment.lastActivityDate : "Inactive")")
                    .frame(width: 50, alignment: .leading)
                Spacer()
            }
            
            SwiftUI.Group{
                Text("\(enrollment.totalApproved)")
                    .frame(width: 60, alignment: .center)
                Spacer()
            }
            
            SwiftUI.Group{
                if viewModel.currentCourse.slipDays > 0 {
                    Text("\(enrollment.slipDaysRemaining)")
                        .frame(width: 60, alignment: .center)
                    Spacer()
                }
            }
            
            
            
            SwiftUI.Group{
                if isEditing {
                    HStack{
                        Text(translateUserStatus(status: enrollment.status))
                           
                        Spacer()
                        Menu("") {
                            Button("promote", action: {})
                            Button("reject", action: {})
                            
                        }
                        .menuStyle(BorderlessButtonMenuStyle())
                        .frame(width: 10)
                    }
                    .frame(width: 75, alignment: .center)
                    
                    
                    
                } else{
                    if enrollment.status == .pending{
                        VStack{
                            Text(translateUserStatus(status: enrollment.status))
                            Button("Accept", action: {acceptUser()})
                        }
                        .frame(width: 75, alignment: .center)
                        
                    } else{
                        Text(translateUserStatus(status: enrollment.status))
                            .frame(width: 75, alignment: .center)
                    }
                }
            }
            
            
            
        }
    }
}

