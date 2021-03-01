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
    
    
    init(){
        let hostname = "localhost"
        let port = 9090
        
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
            .connect(host: hostname, port: port)
    
        self.quickfeedClient = AutograderServiceClient(channel: channel)
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "2"]
        
        self.defaultOptions = CallOptions()
        self.defaultOptions.customMetadata = headers

        
    }
    
    func isAuthorizedTeacher() -> Bool{
       
        let call = self.quickfeedClient.isAuthorizedTeacher(Void(), callOptions: self.defaultOptions)
        
        print("teacher")
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
    
    func getCourses(userStatus: Enrollment.UserStatus) -> [Course]{
        
        let req = EnrollmentStatusRequest.with{
            $0.statuses = [userStatus]
            $0.userID = 2
        }
        
        let unaryCall = self.quickfeedClient.getCoursesByUser(req, callOptions: self.defaultOptions)
        
        do {
            let response = try unaryCall.response.wait()
            print(response.courses)
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
        print("get courses")
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
    
    func getEnrollmentsByCourse(course: Course) -> [Enrollment]{
        let req = EnrollmentRequest.with{
            $0.courseID = course.id
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
            print("getting org")
            let response = try unaryCall.response.wait()
            
            print("getting org")
            print("Call received: \(response.path)")
        } catch {
            print("Call failed: \(error)")
        }
        
    }
    
    
    
    
    
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.channel.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
}
