//
//  StudentViewModel.swift
//  Quickfeed
//

import Foundation


class StudentViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol = ServerProvider.shared
    
    @Published var user: User = ServerProvider.shared.getUser()!
    
    @Published var course: Course
    @Published var group: Group?
    
    @Published var assignments: [Assignment] = []
    @Published var submissions: [Submission] = []
    @Published var enrollments: [Enrollment] = []
    
    init(course: Course) {
        print("New StudentViewModel")
        self.course = course
        
        getAssignments()
        
        if hasGroupAssignments(){
            self.group = provider.getGroupByUserAndCourse(courseID: course.id, groupID: nil, userID: user.id)
        }
        
        getSubmissions()
    }
    
    // MARK: Groups
    func createGroup(name: String, enrollments: [Enrollment]) {
        var users: [User] = []
        for element in enrollments{
            users.append(element.user)
        }
        var group = Group()
        group.name = name
        group.enrollments = enrollments
        group.status = Group.GroupStatus.pending
        group.courseID = course.id
        group.users = users
        self.group = provider.getGroupByUserAndCourse(courseID: self.course.id, groupID: nil, userID: user.id)
        
        let response = self.provider.createGroup(group: group)
        _ = response.always {(response: Result<Group, Error>) in
            switch response {
            case .success( _):
                DispatchQueue.main.async {
                    print("Group created")
                }
            case .failure(let err):
                print("[Error] Connection error or groups not found: \(err)")
            }
        }
    }
    
    // MARK: Enrollments
    func getEnrollment() -> Enrollment?{
        let enrollments = provider.getEnrollmentsByUser(userID: self.user.id, userStatus: [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student, Enrollment.UserStatus.pending])!
        for element in enrollments{
            if element.course.id == course.id{
                return element
            }
        }
        return nil
    }
    
    func getEnrollmentsByCourse() {
        let response = self.provider.getEnrollmentsByCourse(courseID: self.course.id, ignoreGroupMembers: true, withActivity: nil, userStatus: [Enrollment.UserStatus.student])
        _ = response.always {(response: Result<Enrollments, Error>) in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self.enrollments = response.enrollments
                }
            case .failure(let err):
                print("[Error] Connection error or enrollments not found: \(err)")
                self.enrollments = []
            }
        }
    }
    
    // MARK: Courses
    func getSlipdays() -> UInt32? {
        return getEnrollment()!.slipDaysRemaining
    }
    
    // MARK: Assignments
    func getAssignments(){
        let assignments = provider.getAssignments(courseID: course.id)
        
        if assignments != nil {
            self.assignments = assignments!
        }
    }
    
    func hasGroupAssignments() -> Bool{
        for assignment in self.assignments{
            if assignment.isGroupLab{
                return true
            }
        }
        return false
    }
    
    // MARK: Submissions
    func getSubmission(assignment: Assignment) -> Submission? {
        for element in self.submissions {
            if element.assignmentID == assignment.id {
                if assignment.isGroupLab && element.groupID != 0 {
                    return element
                } else if !assignment.isGroupLab && element.groupID == 0{
                    return element
                }
            }
        }
        
        return nil
    }
    
    func getSubmissions(){
        var submissions: [Submission] = []
        
        let individualSubmissions = provider.getSubmissions(userID: user.id, groupID: nil, courseID: course.id)
        if individualSubmissions != nil {
            submissions.append(contentsOf: individualSubmissions!)
        }
        
        if group != nil {
            let groupSubmissions = provider.getSubmissions(userID: nil, groupID: group!.id, courseID: course.id)
            if groupSubmissions != nil {
                submissions.append(contentsOf: groupSubmissions!)
            }
        }
        
        self.submissions = submissions
    }
    
    // MARK: Manual Grading
    func getReviews(reviews: [Review]) -> [Review]{
        var reviews = reviews
        for review in reviews{
            if !review.ready{
                reviews.remove(at: reviews.firstIndex(of: review)!)
            }
        }
        return reviews
    }
    
    func getReview(reviews: [Review]) -> [String]? {
        var feedback: [String] = []
        for review in reviews {
            if review.feedback.count != 0 {
                feedback.append(review.feedback)
            }
        }
        if feedback.count != 0 {
            return feedback
        }
        return nil
    }
    
    // MARK: Misc
    func reload() {
        self.getAssignments()
        self.getSubmissions()
    }
    
    func reset() {
        
    }
    
}
