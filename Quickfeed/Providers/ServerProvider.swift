//
//  ServerProvider.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/02/2021.
//
import Foundation

class ServerProvider: ProviderProtocol{
    var currentUser: User
    var grpcManager: GRPCManager = GRPCManager()
    
    
    
    
  
    init() {
        self.currentUser = self.grpcManager.getUser(userId: 100) ?? User()
    }
    
   
    

    
    func getUser() -> User? {
        return self.currentUser
    }
    
    func getAllCoursesForCurrentUser() -> [Course]? {
        var courses: [Course]? = grpcManager.getCourses(userStatus: Enrollment.UserStatus.teacher, userId: currentUser.id)
        courses?.append(contentsOf: grpcManager.getCourses(userStatus: Enrollment.UserStatus.student, userId: currentUser.id))
        return courses
    }
    
    func getUsersForCourse(course: Course) -> [User] {
        let enrollments = self.getEnrollmentsForCourse(course: course) ?? []
        var users: [User] = []
        for enrollment in enrollments{
            var user = enrollment.user
            user.enrollments.append(enrollment)
            users.append(user)
        }
        
        return users
    }
    
    func getCoursesForCurrentUser() -> [Course]? {

        return grpcManager.getCourses(userStatus: Enrollment.UserStatus.teacher, userId: self.currentUser.id)

    }
    
    func getEnrollmentsByCourse(courseId: UInt64) -> [Enrollment]{
        return self.grpcManager.getEnrollmentsByCourse(courseId: courseId)
        
    }
    
    func isAuthorizedTeacher() -> Bool {
        return grpcManager.isAuthorizedTeacher()
    }
    
    func getCourses() -> [Course] {
        fatalError("Not implemented")
    }
    
    func getUsers() -> [User] {
        fatalError("Not implemented")
    }

    
    func getCourse(courseId: UInt64) -> Course? {
        return self.grpcManager.getCourse(courseId: courseId)
    }
    
    func changeName(newName: String) {
        fatalError("Not implemented")
    }
    
    func getCoursesStudent() -> [Course] {
        fatalError("Not implemented")
    }
    
    func getAssignments(courseID: UInt64) -> [Assignment] {
        assert(courseID != 111)
        return self.grpcManager.getAssignments(courseId: courseID)
    }
    
    func getEnrollmentsForCourse(course: Course) -> [Enrollment]? {
        return self.grpcManager.getEnrollmentsByCourse(courseId: course.id)
    }
    
    func addUserToCourse(course: Course, user: User) -> Bool {
        fatalError("Not implemented")
    }
    
    func changeUserStatus(enrollment: Enrollment, status: Enrollment.UserStatus) -> Status {
        fatalError("Not implemented")
    }
    
    func approveAll(courseId: UInt64) -> Bool {
        fatalError("Not implemented")
    }
    
    func createNewCourse(course: Course) -> Course {
        fatalError("Not implemented")
    }
    
    func updateCourse(course: Course) -> Status {
        fatalError("Not implemented")
    }
    
    func updateCourseVisibility(enrollment: Enrollment) -> Bool {
        fatalError("Not implemented")
    }
    
    func getGroupsForCourse(courseId: UInt64) -> [Group] {
        fatalError("Not implemented")
    }
    
    func updateGroupStatus(groupId: UInt64, status: Group.GroupStatus) -> Status {
        fatalError("Not implemented")
    }
    
    func createGroup(groupId: UInt64, name: String, usersIds: [UInt64]) -> Status {
        fatalError("Not implemented")
    }
    
    func getGroup(groupId: UInt64) -> Group? {
        fatalError("Not implemented")
    }
    
    func deleteGroup(courseId: UInt64, groupId: UInt64) -> Status {
        fatalError("Not implemented")
    }
    
    func getGroupByUserAndCourse(courseId: UInt64, userId: UInt64) -> Group? {
        return self.grpcManager.getGroupByUserAndCourse(userID: userId, courseID: courseId)
    }
    
    func updateGroup(group: Group) -> Status {
        fatalError("Not implemented")
    }
    
    func getSubmissionsByUser(courseId: UInt64, userId: UInt64) -> [Submission] {
        self.grpcManager.getSubmissionsForEnrollment(courseId: courseId, userId: userId)
    }
    
    func getSubmissionsByGroub(courseId: UInt64, groupId: UInt64) -> [Submission] {
        self.grpcManager.getSubbmissionByGroup(courseID: courseId, groupID: groupId)
        //fatalError("Not implemented")
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> CourseSubmissions {
        return self.grpcManager.getSubmissionsByCourse(courseId: courseId, type: type)
    }
    
    func getEnrollmentsForUser(userId: UInt64) -> [Enrollment] {
        self.grpcManager.getEnrollmentsByUser(userID: userId)
    }
    
    func getOrganization(orgName: String) -> Organization {
        fatalError("Not implemented")
    }
    
    func getProviders() -> [String] {
        fatalError("Not implemented")
    }
    
    func updateAssignments(courseId: UInt64) -> Bool {
        fatalError("Not implemented")
    }
    
    func updateSubmission(courseId: UInt64, submisssion: Submission) -> Bool {
        fatalError("Not implemented")
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        fatalError("Not implemented")
    }
    
    func rebuildSubmission(assignmentId: UInt64, submissionId: UInt64) -> Submission? {
        fatalError("Not implemented")
    }
    
    func getRepositories(courseId: UInt64, types: [Repository.Type]) {
        fatalError("Not implemented")
    }
    
    
    // MANUAL GRADING
    
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark] {
        return self.grpcManager.loadCriteria(courseId: courseId, assignmentId: assignmentId)
    }
    
    
}
