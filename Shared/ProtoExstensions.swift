//
//  ProtoModelExstensions.swift
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

extension Submission{
    var buildInfoJSON: SessionBuildInfo {
        let jsonData = self.buildInfo.data(using: .utf8)!
        return try! JSONDecoder().decode(SessionBuildInfo.self, from: jsonData)
    }
    
    var scoreObj: [ScoreObj]? {
        let jsonData = self.scoreObjects.data(using: .utf8)!
        let scoreObject: [ScoreObj]? = try? JSONDecoder().decode([ScoreObj].self, from: jsonData)
        
        return scoreObject
    }
}
