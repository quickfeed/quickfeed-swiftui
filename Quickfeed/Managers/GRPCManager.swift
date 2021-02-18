//
//  GRPCManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 25/01/2021.
//

import Foundation
import NIO
import GRPC
import NIOHPACK

// TODO: Test connection between server and client
class GRPCManager {
    let eventLoopGroup: MultiThreadedEventLoopGroup
    let channel: ClientConnection
    let quickfeedClient: AutograderServiceClient
    
    init(){
        // Setup an `EventLoopGroup` for the connection to run on.
        //
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        // Configure the channel, we're not using TLS so the connection is `insecure`.
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
          .connect(host: "localhost", port: 9090)
        print("GRPC connection")

        // Provide the connection to the generated client.
        self.quickfeedClient = AutograderServiceClient(channel: channel)
        
    }
    
    
    func getOrganization(orgName: String) {
        
        let request = OrgRequest.with{
            $0.orgName = orgName
        }
        
        let headers: HPACKHeaders = ["user": "1"]
        
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
