//
//  GRPCManager.swift
//  Quickfeed
//

import Foundation
import NIO
import GRPC
import NIOHPACK

class GRPCManager {
    static let shared = GRPCManager()
    
    let quickfeedClient: AutograderServiceClient
    let connection: ClientConnection
    let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    var defaultOptions: CallOptions?
    
    private init(){
        let hostname = "localhost"
        let port = 9090
        
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort(hostname, port),
            eventLoopGroup: eventLoopGroup,
            tls: nil // .init()/nil
        )
        self.connection = ClientConnection(configuration: configuration)
        
        self.quickfeedClient = AutograderServiceClient(channel: connection)
        print("Connecting to \(hostname)")
    }
    
    func createHeader(userID: UInt64){
        self.defaultOptions = CallOptions()
        self.defaultOptions!.customMetadata = ["custom-header-1": "value1", "user": "\(userID)"]
    }
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.connection.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
    
    // MARK: Users
    func setUser(userID: UInt64){
        createHeader(userID: userID)
    }
    
    func getUser() -> User?{
        let call = self.quickfeedClient.getUser(Void(), callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getUsers() -> [User]?{
        let call = self.quickfeedClient.getUsers(Void(), callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.users
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getUserByCourse(courseCode: String, courseYear: UInt32, userLogin: String) -> User? {
        var request = CourseUserRequest()
        request.courseCode = courseCode
        request.courseYear = courseYear
        request.userLogin = userLogin
        
        let call = self.quickfeedClient.getUserByCourse(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateUser(user: User) {
        let _ = self.quickfeedClient.updateUser(user, callOptions: self.defaultOptions)
    }
    
    func isAuthorizedTeacher() -> Bool{
        let call = self.quickfeedClient.isAuthorizedTeacher(Void(), callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.isAuthorized
        } catch {
            print("Call failed: \(error)")
        }
        return false
    }
    
    // MARK: Groups
    func getGroup(groupID: UInt64) -> Group?{
        var request = GetGroupRequest()
        request.groupID = groupID
        
        let call = self.quickfeedClient.getGroup(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getGroupByUserAndCourse(userID: UInt64, groupID: UInt64?, courseID: UInt64) -> Group?{
        var request = GroupRequest()
        request.userID = userID
        request.courseID = courseID

        if groupID != nil{
            request.groupID = groupID!
        }

        let call = self.quickfeedClient.getGroupByUserAndCourse(request, callOptions: self.defaultOptions)

        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getGroupsByCourse(courseID: UInt64) -> EventLoopFuture<Groups>{
        var request = CourseRequest()
        request.courseID = courseID

        let call = self.quickfeedClient.getGroupsByCourse(request, callOptions: self.defaultOptions)

        return call.response
    }
    
    func createGroup(group: Group) -> EventLoopFuture<Group>{
        let call = self.quickfeedClient.createGroup(group, callOptions: self.defaultOptions)

        return call.response
    }
    
    func updateGroup(group: Group){
        let _ = self.quickfeedClient.updateGroup(group, callOptions: self.defaultOptions)
    }
    
    func deleteGroup(userID: UInt64, groupID: UInt64, courseID: UInt64){
        var request = GroupRequest()
        request.userID = userID
        request.groupID = groupID
        request.courseID = courseID
        
        let _ = self.quickfeedClient.deleteGroup(request, callOptions: self.defaultOptions)
    }
    
    // MARK: Enrollments
    func getEnrollmentsByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Enrollment]?{
        var request = EnrollmentStatusRequest()
        request.userID = userID
        request.statuses = userStatus

        let call = self.quickfeedClient.getEnrollmentsByUser(request, callOptions: self.defaultOptions)

        do {
            let response = try call.response.wait()
            return response.enrollments
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getEnrollmentsByCourse(courseID: UInt64, ignoreGroupMembers: Bool?, withActivity: Bool?, userStatus: [Enrollment.UserStatus]) -> EventLoopFuture<Enrollments>{
        var request = EnrollmentRequest()
        request.courseID = courseID
        request.statuses = userStatus
        
        if ignoreGroupMembers != nil {
            request.ignoreGroupMembers = ignoreGroupMembers!
        }
        if withActivity != nil {
            request.withActivity = withActivity!
        }

        let call = self.quickfeedClient.getEnrollmentsByCourse(request, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func createEnrollment(enrollment: Enrollment){
        let _ = self.quickfeedClient.createEnrollment(enrollment, callOptions: self.defaultOptions)
    }
    
    func updateEnrollment(enrollment: Enrollment){
        let _ = self.quickfeedClient.updateEnrollment(enrollment, callOptions: self.defaultOptions)
    }
    
    func updateEnrollments(courseID: UInt64){
        var request = CourseRequest()
        request.courseID = courseID
        
        let _ = self.quickfeedClient.updateEnrollments(request, callOptions: self.defaultOptions)
    }
    
    // MARK: Courses
    func getCourse(courseID: UInt64) -> Course?{
        var request = CourseRequest()
        request.courseID = courseID
        
        let call = self.quickfeedClient.getCourse(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getCourses() -> [Course]?{
        let call = self.quickfeedClient.getCourses(Void(), callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.courses
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getCoursesByUser(userID: UInt64, userStatus: [Enrollment.UserStatus]) -> [Course]?{
        var request = EnrollmentStatusRequest()
        request.userID = userID
        request.statuses = userStatus
        
        let call = self.quickfeedClient.getCoursesByUser(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.courses
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func createCourse(course: Course) -> Course?{
        let call = self.quickfeedClient.createCourse(course, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateCourse(course: Course){
        let _ = self.quickfeedClient.updateCourse(course, callOptions: self.defaultOptions)
    }
    
    func updateCourseVisibility(enrollment: Enrollment){
        let _ = self.quickfeedClient.updateCourseVisibility(enrollment, callOptions: self.defaultOptions)
    }
    
    // MARK: Assignments
    func getAssignments(courseID: UInt64) -> [Assignment]?{
        var request = CourseRequest()
        request.courseID = courseID
        
        let call = self.quickfeedClient.getAssignments(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.assignments
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateAssignments(courseID: UInt64) -> Bool{
        var request = CourseRequest()
        request.courseID = courseID

        let call = self.quickfeedClient.updateAssignments(request, callOptions: self.defaultOptions)
        
        do {
            let _ = try call.response.wait()
            return true
        } catch {
            print("Call failed: \(error)")
        }
        return false
    }
    
    // MARK: Submissions
    func getSubmissions(userID: UInt64?, groupID: UInt64?, courseID: UInt64) -> [Submission]?{
        var request = SubmissionRequest()
        request.courseID = courseID
        
        if userID != nil {
            request.userID = userID!
        }
        
        if groupID != nil{
            request.groupID = groupID!
        }
        
        let call = self.quickfeedClient.getSubmissions(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.submissions
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getSubmissionsByCourse(courseID: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions>{
        var request = SubmissionsForCourseRequest()
        request.courseID = courseID
        request.type = type

        let call = self.quickfeedClient.getSubmissionsByCourse(request, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func updateSubmission(submissionID: UInt64, courseID: UInt64, score: UInt32, released: Bool, status: Submission.Status) -> Bool {
        var request = UpdateSubmissionRequest()
        request.submissionID = submissionID
        request.courseID = courseID
        request.score = score
        request.released = released
        request.status = status

        let call = self.quickfeedClient.updateSubmission(request, callOptions: self.defaultOptions)
        
        do {
            _ = try call.response.wait()
            return true
        } catch {
            print("Call failed: \(error)")
        }
        return false
    }
    
    func updateSubmissions(courseID: UInt64, assignmentID: UInt64, scoreLimit: UInt32, release: Bool, approve: Bool){
        var request = UpdateSubmissionsRequest()
        request.courseID = courseID
        request.assignmentID = assignmentID
        request.scoreLimit = scoreLimit
        request.release = release
        request.approve = approve
        
        let _ = self.quickfeedClient.updateSubmissions(request, callOptions: self.defaultOptions)
    }
    
    func rebuildSubmission(submissionID: UInt64, assignmentID: UInt64) -> Bool{
        var request = RebuildRequest()
        request.submissionID = submissionID
        request.assignmentID = assignmentID
        
        let call = self.quickfeedClient.rebuildSubmission(request, callOptions: self.defaultOptions)
        
        do {
            let _ = try call.response.wait()
            return true
        } catch {
            print("Call failed: \(error)")
        }
        return false
    }
    
    // MARK: Manual Grading
    func createBenchmark(gradingBenchmark: GradingBenchmark) -> GradingBenchmark? {
        let call = self.quickfeedClient.createBenchmark(gradingBenchmark, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateBenchmark(gradingBenchmark: GradingBenchmark) {
        let _ = self.quickfeedClient.updateBenchmark(gradingBenchmark, callOptions: self.defaultOptions)
    }
    
    func deleteBenchmark(gradingBenchmark: GradingBenchmark) {
        let _ = self.quickfeedClient.deleteBenchmark(gradingBenchmark, callOptions: self.defaultOptions)
    }
    
    func createCriterion(gradingCriterion: GradingCriterion) -> GradingCriterion? {
        let call = self.quickfeedClient.createCriterion(gradingCriterion, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateCriterion(gradingCriterion: GradingCriterion) {
        let _ = self.quickfeedClient.updateCriterion(gradingCriterion, callOptions: self.defaultOptions)
    }
    
    func deleteCriterion(gradingCriterion: GradingCriterion) {
        let _ = self.quickfeedClient.deleteCriterion(gradingCriterion, callOptions: self.defaultOptions)
    }
    
    func createReview(courseID: UInt64, review: Review) -> Review?{
        var request = ReviewRequest()
        request.courseID = courseID
        request.review = review
        
        let call = self.quickfeedClient.createReview(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func updateReview(courseID: UInt64, review: Review) {
        var request = ReviewRequest()
        request.courseID = courseID
        request.review = review
        
        let _ = self.quickfeedClient.updateReview(request, callOptions: self.defaultOptions)
    }
    
    func getReviewers(submissionID: UInt64, courseID: UInt64) -> Reviewers?{
        var request = SubmissionReviewersRequest()
        request.submissionID = submissionID
        request.courseID = courseID
        
        let call = self.quickfeedClient.getReviewers(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func loadCriteria(courseID: UInt64, assignmentID: UInt64) -> [GradingBenchmark]?{
        var request = LoadCriteriaRequest()
        request.courseID = courseID
        request.assignmentID = assignmentID
        
        let call = self.quickfeedClient.loadCriteria(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.benchmarks
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    // MARK: Misc
    func getProviders() -> [String]?{
        let call = self.quickfeedClient.getProviders(Void(), callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.providers
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func getOrganization(orgName: String) -> EventLoopFuture<Organization>{
        var request = OrgRequest()
        request.orgName = orgName

        let call = self.quickfeedClient.getOrganization(request, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func getRepositories(courseID: UInt64, repositoryTypes: [Repository.TypeEnum]) -> Repositories?{
        var request = URLRequest()
        request.courseID = courseID
        request.repoTypes = repositoryTypes
        
        let call = self.quickfeedClient.getRepositories(request, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func isEmptyRepo(userID: UInt64, groupID: UInt64, courseID: UInt64){
        var request = RepositoryRequest()
        request.userID = userID
        request.groupID = groupID
        request.courseID = courseID
        
        let _ = self.quickfeedClient.isEmptyRepo(request, callOptions: self.defaultOptions)
    }
}
