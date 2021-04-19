//
//  GRPCManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 25/01/2021.
//
import Foundation
import NIO
import NIOSSL
import GRPC
import NIOHPACK

class GRPCManager {
    let eventLoopGroup: EventLoopGroup
    let channel: ClientConnection
    let quickfeedClient: AutograderServiceClient
    var defaultOptions: CallOptions
    static let shared = GRPCManager()
    var userID: UInt64?
    
    private init(){
        let hostname = "localhost"
        let port = 9090
        
        self.userID = 100
        
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
            .connect(host: hostname, port: port)
        self.quickfeedClient = AutograderServiceClient(channel: channel)

        print("Connecting to \(hostname)")
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "\(self.userID!)"]
        
        self.defaultOptions = CallOptions()
        self.defaultOptions.customMetadata = headers
        
        
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
    
    
    func getProviders(){
        let call = self.quickfeedClient.getProviders(Void())
        
        do {
            print("Get providers")
            
            print("connectivity state: \(self.channel.connectivity.state)")
            let response = try call.response.wait()
            
            
            print("Call received: \(response.providers)")
        } catch {
            print("Call failed: \(error)")
        }
    }
    
    func getUser() -> User?{
        let call = self.quickfeedClient.getUser(Void(), callOptions: self.defaultOptions)
        
        do {
            let user = try call.response.wait()
            return user
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    func updateUser(user: User) {
        _ = self.quickfeedClient.updateUser(user, callOptions: self.defaultOptions)
    }
    
    func getUsers() -> [User]? {
        let call = self.quickfeedClient.getUsers(Void(), callOptions: self.defaultOptions)
        
        do {
            let users = try call.response.wait()
            return users.users
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    func getCourses(userStatus: Enrollment.UserStatus, userId: UInt64?) -> [Course]{
        
        let req = EnrollmentStatusRequest.with{
            $0.statuses = [userStatus]
            if userId == nil{
                $0.userID = self.userID!
            }else{
                $0.userID = userId!
            }
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
    
    func updateEnrollment(enrollment: Enrollment){
        let call = self.quickfeedClient.updateEnrollment(enrollment, callOptions: self.defaultOptions)
        do {
            _ = try call.response.wait()
        } catch {
            print("Updating enrollment failed: \(error)")
        }
    }
    
    func getCourse(courseId: UInt64) -> Course? {
        
        let req = CourseRequest.with{
            $0.courseID = courseId
        }
        
        let unaryCall = self.quickfeedClient.getCourse(req, callOptions: self.defaultOptions)
        
        do {
            let response = try unaryCall.response.wait()
            return response
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    func getCourses() -> [Course]? {
        let call = self.quickfeedClient.getCourses(Void(), callOptions: self.defaultOptions)
        do {
            let response = try call.response.wait()
            return response.courses
        } catch {
            print("Call failed: \(error)")
        }
        return nil
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
    
    func getEnrollmentsByCourse(courseId: UInt64) -> EventLoopFuture<Enrollments>{
        let req = EnrollmentRequest.with{
            $0.courseID = courseId
            $0.withActivity = true
        }
        
        let call = self.quickfeedClient.getEnrollmentsByCourse(req, callOptions: self.defaultOptions)
        
        return call.response
        
    }
    
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
    
    
    func createGroup(gruop: Group) -> EventLoopFuture<Group>{
        
        let call = self.quickfeedClient.createGroup(gruop, callOptions: self.defaultOptions)
        
        return call.response
    }
    
    func getGroupsByCourse(courseId: UInt64) -> EventLoopFuture<Groups>{
        let req = CourseRequest.with{
            $0.courseID = courseId
        }
        
        let call = self.quickfeedClient.getGroupsByCourse(req, callOptions: self.defaultOptions)
        
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
    
    func getOrganization(orgName: String) -> Organization? {
        var test = OrgRequest()
        test.orgName = orgName
        
        let call = self.quickfeedClient.getOrganization(test, callOptions: self.defaultOptions)
        
        do {
            let resp = try call.response.wait()
            return resp
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    
    
    
    
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.channel.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
}
