import Foundation


struct StudentCourse: Identifiable {
    let id: UUID
    var courseCode: String
    var courseName: String
    var courseYear: Int
    var labs: [StudentLab]
    
    
    init(id: UUID = UUID(), courseCode: String, courseName: String, courseYear: Int, labs: [StudentLab]){
        self.id = id
        self.courseCode = courseCode
        self.courseName = courseName
        self.courseYear = courseYear
        self.labs = labs
    }
}

extension StudentCourse {
    static var data: [StudentCourse]{
        [
            StudentCourse(courseCode: "DAT310", courseName: "Operating Systems", courseYear: 2020, labs: StudentLab.data)
        ]
    }
}

