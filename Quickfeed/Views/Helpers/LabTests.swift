//
//  LabTests.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/02/2021.
//

import SwiftUI

struct LabTests: View {
    var submission: Submission
    
    var body: some View {
        VStack{
            HStack{
                Text("Test name")
                    .fontWeight(.bold)
                    .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
                Text("Score")
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
                Text("Weight")
                    .fontWeight(.bold)
                    .frame(width: 50, alignment: .leading)
                    .padding(.leading)
            }
            ForEach(submission.scoreObj!, id: \.self) { scoreObject in
                Divider()
                HStack{
                    Text(scoreObject.TestName)
                        .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)
                    Text("\(scoreObject.Score) / \(scoreObject.MaxScore) pts")
                        .frame(width: 120, alignment: .leading)
                    Text(String(scoreObject.Weight))
                        .frame(width: 50, alignment: .leading)
                        .padding(.leading)
                }
                .padding(.top, 1.0)
            }
        }
    }
}

