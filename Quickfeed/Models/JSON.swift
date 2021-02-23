//
//  JSON.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 09/02/2021.
//

import Foundation

struct SessionBuildInfo: Codable {
    var builddate: String
    var buildid: Int
    var buildlog: String
    var execTime: Int
}

struct ScoreObj: Codable, Hashable {
    var TestName: String
    var Score: Int
    var MaxScore: Int
    var Weight: Int
}


