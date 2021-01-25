import Foundation

struct StudentLab: Identifiable, Codable {
    let id: UUID
    var labTitle: String
    var status: String
    var delivered: String
    var deadline: String
    var testResults: [StudentTestResult]
    var totalTests: Int{
        var total = 0
        for test in testResults {
            total += test.totalTests
        }
        return total
    }
    var testsPassed: Int{
        var total = 0
        for test in testResults{
            total = test.testsPassed
        }
        return total
    }
    
    
    
    
    init(id: UUID = UUID(), labTitle: String, delivered: String, deadline: String, status: String, testResults: [StudentTestResult]) {
        self.id = id
        self.labTitle = labTitle
        self.delivered = delivered
        self.deadline = deadline
        self.status = status
        self.testResults = testResults
    }
    
}

extension StudentLab {
    static var data: [StudentLab]{
        [
            StudentLab(labTitle: "lab1", delivered: "fre. 4. sep., 18:27", deadline: "søn. 30. aug., 23:59", status: "Approved", testResults: StudentTestResult.data),
            StudentLab(labTitle: "lab2", delivered: "fre. 4. sep., 18:27", deadline: "søn. 30. aug., 23:59", status: "Approved", testResults: StudentTestResult.data)
        ]
    }
}
