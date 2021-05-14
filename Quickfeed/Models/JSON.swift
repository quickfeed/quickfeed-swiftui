//
//  JSON.swift
//  Quickfeed
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
