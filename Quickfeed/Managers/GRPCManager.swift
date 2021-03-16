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

// TODO: Test connection between server and client
class GRPCManager {
    let eventLoopGroup: MultiThreadedEventLoopGroup
    let channel: ClientConnection
    let quickfeedClient: AutograderServiceClient
    var defaultOptions: CallOptions
    
    
    init(userID: UInt64){
        let hostname = "localhost"
        let port = 9090
        
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
            .connect(host: hostname, port: port)
        
        self.quickfeedClient = AutograderServiceClient(channel: channel)

        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "\(userID)"]
        
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
    
    func getUser(userId: UInt64) -> User?{
        let call = self.quickfeedClient.getUser(Void(), callOptions: self.defaultOptions)
        
        do {
            let user = try call.response.wait()
            return user
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    
    
    func getCourses(userStatus: Enrollment.UserStatus, userId: UInt64) -> [Course]{
        
        let req = EnrollmentStatusRequest.with{
            $0.statuses = [userStatus]
            $0.userID = userId
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
    
    func getEnrollmentsByCourse(courseId: UInt64) -> [Enrollment]{
        let req = EnrollmentRequest.with{
            $0.courseID = courseId
            $0.withActivity = true
        }
        
        let call = self.quickfeedClient.getEnrollmentsByCourse(req, callOptions: self.defaultOptions)
        
        do {
            let response = try call.response.wait()
            return response.enrollments
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
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
    
    
    func getOrganization(orgName: String) {
        
        let request = OrgRequest.with{
            $0.orgName = orgName
        }
        
        
        
        let unaryCall = self.quickfeedClient.getOrganization(request, callOptions: self.defaultOptions)
        
        do {
            
            let response = try unaryCall.response.wait()
            
            
            print("Call received: \(response.path)")
        } catch {
            print("Call failed: \(error)")
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
    
    
    
    
    
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.channel.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
}
