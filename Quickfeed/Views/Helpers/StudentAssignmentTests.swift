//
//  StudentAssignmentTests.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 02/02/2021.
//

import SwiftUI

struct StudentAssignmentTests: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Test name")
                    .fontWeight(.bold)
                Text("TestGitQuestionsAG")
                Text("TestMissingSemesterQuestionsAG")
                Text("TestShellQuestionsAG")
                Text("TestToken")
                Text("Total score")
                
            }
            Spacer()
            VStack(alignment: .leading){
                Text("Score")
                    .fontWeight(.bold)
                Text("10/10 pts")
                Text("9/9 pts")
                Text("20/20 pts")
                Text("4/4 pts")
                Text("100 %")
            }
            VStack(alignment: .trailing){
                Text("Weight")
                    .fontWeight(.bold)
                Text("1")
                Text("1")
                Text("1")
                Text("5")
                Text("100 %")
            }
        }
    }
}

struct StudentAssignmentTests_Previews: PreviewProvider {
    static var previews: some View {
        StudentAssignmentTests()
    }
}
