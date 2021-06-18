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
    
    let headers: HPACKHeaders? = nil
    var defaultOptions: CallOptions?
    var userID: UInt64?
    
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
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.connection.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
    
    // MARK: Users
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
    
//    func getGroupByUserAndCourse(userID: UInt64, groupID: UInt64?, courseID: UInt64) -> Group?{
//        var request = GroupRequest()
//        request.userID = userID
//        request.courseID = courseID
//
//        if groupID != nil{
//            request.groupID = groupID!
//        }
//
//        let call = self.quickfeedClient.getGroupByUserAndCourse(request, callOptions: self.defaultOptions)
//
//        do {
//            let response = try call.response.wait()
//            return response
//        } catch {
//            print("Call failed: \(error)")
//        }
//        return nil
//    }
    
//    func getGroupsByCourse(courseID: UInt64) -> [Group]?{
//        var request = CourseRequest()
//        request.courseID = courseID
//
//        let call = self.quickfeedClient.getGroupsByCourse(request, callOptions: self.defaultOptions)
//
//        do {
//            let response = try call.response.wait()
//            return response.groups
//        } catch {
//            print("Call failed: \(error)")
//        }
//        return nil
//    }
    
//    func createGroup(group: Group) -> Bool{
//        let call = self.quickfeedClient.createGroup(group, callOptions: self.defaultOptions)
//
//        do {
//            let _ = try call.response.wait()
//            return true
//        } catch {
//            print("Call failed: \(error)")
//        }
//        return false
//    }
    
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
    
//    func createCourse(course: Course) -> Bool{
//        let call = self.quickfeedClient.createCourse(course, callOptions: self.defaultOptions)
//        
//        do {
//            let _ = try call.response.wait()
//            return true
//        } catch {
//            print("Call failed: \(error)")
//        }
//        return false
//    }
    
    func updateCourse(course: Course){
        let _ = self.quickfeedClient.updateCourse(course, callOptions: self.defaultOptions)
    }
    
    func updateCourseVisibility(enrollment: Enrollment){
        let _ = self.quickfeedClient.updateCourseVisibility(enrollment, callOptions: self.defaultOptions)
    }
    
    // TODO: Duplicates with different arguments or returns (see later which one is best to use)
    func getGroupByUserAndCourse(userID: UInt64, courseID: UInt64) -> Group? {
        let req = GroupRequest.with{
            $0.courseID = courseID
            $0.userID = userID
        }
        
        let call = self.quickfeedClient.getGroupByUserAndCourse(req, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups>{
        let req = CourseRequest.with{
            $0.courseID = courseId
        }
        
        let call = self.quickfeedClient.getGroupsByCourse(req, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func createGroup(group: Group) -> EventLoopFuture<Group>{
        
        let call = self.quickfeedClient.createGroup(group, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func getCoursesForCurrentUser() -> [Course]{
        let req = EnrollmentStatusRequest.with{
            $0.statuses = [Enrollment.UserStatus.teacher, Enrollment.UserStatus.student]
            $0.userID = self.userID!
        }
        
        let unaryCall = self.quickfeedClient.getCoursesByUser(req, callOptions: self.defaultOptions)
        
        do {
            let response = try unaryCall.response.wait()
            
            return response.courses
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
    }
    
    func createCourse(course: Course) -> Course?{
        let call = self.quickfeedClient.createCourse(course, callOptions: self.defaultOptions)
        
        do {
            let resp = try call.response.wait()
            return resp
        } catch {
            print("Call failed: \(error)")
            return nil
        }
    }
    
    // TODO: clean up the rest of the gRPC methods
    func setUser(userID: UInt64){
        self.userID = userID
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "\(self.userID!)"]
        self.defaultOptions = CallOptions()
        self.defaultOptions!.customMetadata = headers
    }
    
    func getProviders(){
        let call = self.quickfeedClient.getProviders(Void())
        
        do {
            print("Get providers")
            
            print("connectivity state: \(self.connection.connectivity.state)")
            let response = try call.response.wait()
            
            
            print("Call received: \(response.providers)")
        } catch {
            print("Call failed: \(error)")
        }
    }
    
    func updateEnrollment(enrollment: Enrollment){
        let call = self.quickfeedClient.updateEnrollment(enrollment, callOptions: self.defaultOptions)
        do {
            _ = try call.response.wait()
        } catch {
            print("Updating enrollment failed: \(error)")
        }
    }
    
    func getSubmissionsForEnrollment(courseId: UInt64, userId: UInt64) -> [Submission]{
        let req = SubmissionRequest.with{
            $0.courseID = courseId
            $0.userID = userId
        }
        let call = self.quickfeedClient.getSubmissions(req, callOptions: self.defaultOptions)
        do {
            let response = try call.response.wait()
            return response.submissions
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
        
    }
    
    func updateSubmission(courseId: UInt64, submission: Submission) -> Bool{
        let req = UpdateSubmissionRequest.with{
            $0.courseID = courseId
            $0.submissionID = submission.id
            $0.score = submission.score
            $0.released = submission.released
            $0.status = submission.status
        }
        let call = self.quickfeedClient.updateSubmission(req, callOptions: self.defaultOptions)
        do {
            _ = try call.response.wait()
            return true
        } catch {
            print("Call failed: \(error)")
            return false
        }
    }
    
    func updateSubmissions(assignmentID: UInt64, courseID: UInt64, score: UInt32, release: Bool, approve: Bool) {
        let req = UpdateSubmissionsRequest.with{
            $0.courseID = courseID
            $0.assignmentID = assignmentID
            $0.scoreLimit = score
            $0.release = release
            $0.approve = approve
        }
        let call = self.quickfeedClient.updateSubmissions(req, callOptions: self.defaultOptions)
        do {
            _ = try call.response.wait()
            
        } catch {
            print("Call failed: \(error)")
            
        }
    }
    
    func getSubmissionsByCourse(courseId: UInt64, type: SubmissionsForCourseRequest.TypeEnum) -> EventLoopFuture<CourseSubmissions>{
        let req = SubmissionsForCourseRequest.with{
            $0.courseID = courseId
            $0.type = type
        }
        
        let call = self.quickfeedClient.getSubmissionsByCourse(req, callOptions: self.defaultOptions)
        return call.response
    }
    func getSubbmissionByGroup(courseID: UInt64, groupID: UInt64) -> [Submission] {
        let req = SubmissionRequest.with{
            $0.courseID = courseID
            $0.groupID = groupID
        }
        let call = self.quickfeedClient.getSubmissions(req, callOptions: self.defaultOptions)
        do {
            let response = try call.response.wait()
            return response.submissions
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
    }
    
    func createEnrollment(courseID: UInt64, userID: UInt64) {
        var enrollment = Enrollment()
        enrollment.courseID = courseID
        enrollment.userID = userID
        
        _ = self.quickfeedClient.createEnrollment(enrollment, callOptions: self.defaultOptions)
    }
    
    
    func getEnrollmentsByUser(userID: UInt64) -> [Enrollment] {
        let req = EnrollmentStatusRequest.with{
            $0.userID = userID
        }
        
        let call = self.quickfeedClient.getEnrollmentsByUser(req, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.enrollments
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
    }
    
    func getEnrollmentsByCourse(courseId: UInt64, ignoreGroupMembers: Bool?, enrollmentStatus: [Enrollment.UserStatus]?) -> EventLoopFuture<Enrollments>{
        let req = EnrollmentRequest.with{
            $0.courseID = courseId
            $0.withActivity = true
            if ignoreGroupMembers != nil {
                $0.ignoreGroupMembers = ignoreGroupMembers!
            }
            if enrollmentStatus != nil{
                $0.statuses = enrollmentStatus!
            }
        }
        
        let call = self.quickfeedClient.getEnrollmentsByCourse(req, callOptions: self.defaultOptions)
        
        return call.response
        
    }
    
    func getAssignments(courseId: UInt64) -> [Assignment]{
        
        let req = CourseRequest.with{
            $0.courseID = courseId
        }
        
        let call = self.quickfeedClient.getAssignments(req, callOptions: self.defaultOptions)
        
        do {
            let resp = try call.response.wait()
            return resp.assignments
        } catch {
            print(courseId)
            print("Call failed: \(error)")
        }
        
        return []
    }
    
    func updateAssignments(courseId: UInt64) -> Bool{
        let req = CourseRequest.with{
            $0.courseID = courseId
        }
        
        let call = self.quickfeedClient.updateAssignments(req, callOptions: self.defaultOptions)
        
        do {
            _ = try call.response.wait()
            return true
        } catch {  
            print("Call failed: \(error)")
            return false
        }
    }
    
    
    // MANUAL GRADING
    
    
    func createReview(courseId: UInt64, review: Review) -> Review?{
        let req = ReviewRequest.with{
            $0.courseID = courseId
            $0.review = review
        }
        
        let call = self.quickfeedClient.createReview(req, callOptions: self.defaultOptions)
        do {
            let resp = try call.response.wait()
            return resp
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
        
    }
    
    func updateReview(courseId: UInt64, review: Review){
        let req = ReviewRequest.with{
            $0.courseID = courseId
            $0.review = review
        }
        
        let call = self.quickfeedClient.updateReview(req, callOptions: defaultOptions)
        
        do {
            _ = try call.response.wait()
            return
        } catch {
            print("Call failed: \(error)")
        }
        
        
    }
    
    func getReviewers(submissionId: UInt64, courseId: UInt64) -> Reviewers?{
        let req = SubmissionReviewersRequest.with{
            $0.courseID = courseId
            $0.submissionID  = submissionId
        }
        
        let call = self.quickfeedClient.getReviewers(req, callOptions: self.defaultOptions)
        do {
            let resp = try call.response.wait()
            return resp
        } catch {
            print("Call failed: \(error)")
        }
        return nil
    }
    
    func loadCriteria(courseId: UInt64, assignmentId: UInt64) -> [GradingBenchmark]{
        let req = LoadCriteriaRequest.with{
            $0.courseID = courseId
            $0.assignmentID = assignmentId
        }
        
        let call = self.quickfeedClient.loadCriteria(req, callOptions: self.defaultOptions)
        
        do {
            let resp = try call.response.wait()
            return resp.benchmarks
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
    }
    
    func getOrganization(orgName: String) -> EventLoopFuture<Organization> {
        var orgRequest = OrgRequest()
        orgRequest.orgName = orgName
        
        let call = self.quickfeedClient.getOrganization(orgRequest, callOptions: self.defaultOptions)
        
        return call.response
    }
}
