import Foundation

struct StudentTestResult: Identifiable, Codable{
    let id: UUID
    var name: String
    var weight: Int
    var totalTests: Int
    var testsPassed: Int
    
    init(id: UUID = UUID(), name: String, weight: Int, totalTests: Int, testsPassed: Int) {
        self.id = id
        self.name = name
        self.weight = weight
        self.totalTests = totalTests
        self.testsPassed = testsPassed
        
    }
}

extension StudentTestResult {
    static var data: [StudentTestResult]{
        [
            StudentTestResult(name: "TestGitQuestionsAG", weight: 1, totalTests: 10, testsPassed: 10),
            StudentTestResult(name: "TestMissingSemesterQuestionsAG", weight: 1, totalTests: 9, testsPassed: 9),
            StudentTestResult(name: "TestShellQuestionsAG", weight: 1, totalTests: 20, testsPassed: 20),
            StudentTestResult(name: "TestToken", weight: 5, totalTests: 4, testsPassed: 4)
        ]
    }
}
