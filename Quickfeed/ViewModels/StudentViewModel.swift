//
//  StudentViewModel.swift
//  Quickfeed
//

import Foundation


class StudentViewModel: UserViewModelProtocol{
    static let shared: StudentViewModel = StudentViewModel()
    var provider: ProviderProtocol = ServerProvider.shared
    @Published var user: User = ServerProvider.shared.getUser()!
    @Published var course: Course?
    @Published var group: Group?
    @Published var assignments: [Assignment]?
    @Published var submissions: [Submission]?
    @Published var enrollments: [Enrollment] = []
    
    private init() {
        print("New StudentViewModel")
    }
    
    func setCourse(course: Course){
        self.course = course
        self.group = provider.getGroupByUserAndCourse(courseID: course.id, groupID: nil, userID: user.id)
    }
    
    func createGroup(name: String, enrollments: [Enrollment]) {
        var users: [User] = []
        for element in enrollments{
            users.append(element.user)
        }
        var group = Group()
        group.name = name
        group.enrollments = enrollments
        group.status = Group.GroupStatus.pending
        group.courseID = course!.id
        group.users = users
        
        var errString: String? = nil
        let response = self.provider.createGroup(group: group)
        _ = response.always {(response: Result<Group, Error>) in
            switch response {
            case .success( _):
                DispatchQueue.main.async {
                    errString = nil
                    print("yey")
                }
            case .failure(let err):
                print("[Error] Connection error or groups not found: \(err)")
                errString = err.localizedDescription
            }
        }
    }
    
    func getEnrollmentForCurrentCourse() -> Enrollment?{
        let enrollments = provider.getEnrollmentsByUser(userID: self.user.id, userStatus: [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student, Enrollment.UserStatus.pending])!
        for element in enrollments{
            if element.course.id == course!.id{
                return element
            }
        }
        return nil
    }
    
    func getEnrollmentsByCourse() {
        let response = self.provider.getEnrollmentsByCourse(courseID: self.course!.id, ignoreGroupMembers: true, withActivity: nil, userStatus: [Enrollment.UserStatus.student])
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
    
    func getAssignments(){
        self.assignments = provider.getAssignments(courseID: course!.id)!
    }
    
    func hasGroupAssignments() -> Bool{
        if self.assignments != nil{
            for assignment in self.assignments!{
                if assignment.isGroupLab{
                    return true
                }
            }
        }
        return false
    }
    
    func getSubmission(assignment: Assignment) -> Submission? {
        if self.submissions != nil {
            for element in self.submissions! {
                if element.assignmentID == assignment.id {
                    if assignment.isGroupLab && element.groupID != 0 {
                        return element
                    } else if !assignment.isGroupLab && element.groupID == 0{
                        return element
                    }
                }
            }
        }
        return nil
    }
    
    func getSubmissions(){
        var submissions = provider.getSubmissions(userID: user.id, groupID: nil, courseID: course!.id)!
        if self.group != nil{
            submissions.append(contentsOf: provider.getSubmissions(userID: nil, groupID: group!.id, courseID: course!.id)!)
        }
        self.submissions = submissions
    }
    
    func getSlipdays() -> UInt32? {
        let enrollments = provider.getEnrollmentsByUser(userID: self.user.id, userStatus: [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student, Enrollment.UserStatus.pending])!
        for element in enrollments{
            if element.courseID == course!.id{
                return element.slipDaysRemaining
            }
        }
        return nil
    }
    
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
    
    func reload() {
        self.getAssignments()
        self.getSubmissions()
    }
    
    
    func reset() {
        
    }
    
}
