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
    
    
    init(){
        let hostname = "localhost"
        let port = 9090
        
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
            .connect(host: hostname, port: port)
    
        self.quickfeedClient = AutograderServiceClient(channel: channel)

        
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
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "\(userId)"]
        
        var callOptions = CallOptions()
        callOptions.customMetadata = headers
        let call = self.quickfeedClient.getUser(Void(), callOptions: callOptions)
        
        do {
            let user = try call.response.wait()
            return user
        } catch {
            print("Call failed: \(error)")
        }
        
        return nil
    }
    
    func getCourses(userStatus: Enrollment.UserStatus) -> [Course]{
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "111"]
        
        var callOptions = CallOptions()
        callOptions.customMetadata = headers
        let req = EnrollmentStatusRequest.with{
            $0.statuses = [userStatus]
        }
      
        let unaryCall = self.quickfeedClient.getCoursesByUser(req, callOptions: callOptions)
        
        do {
            let response = try unaryCall.response.wait()
            print(response.courses)
            return response.courses
        } catch {
            print("Call failed: \(error)")
        }
        
        return []
        
    }
    
    
    func getOrganization(orgName: String) {
        
        let request = OrgRequest.with{
            $0.orgName = orgName
        }
        
        let headers: HPACKHeaders = ["custom-header-1": "value1", "user": "1"]
        
        var callOptions = CallOptions()
        callOptions.customMetadata = headers
        
        
        
        let unaryCall = self.quickfeedClient.getOrganization(request, callOptions: callOptions)
        
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
