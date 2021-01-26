//
//  GRPCManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 25/01/2021.
//

import Foundation
import NIO
import GRPC

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
          .connect(host: "bff1bad572f5.ngrok.io", port: 9091)

        // Provide the connection to the generated client.
        self.quickfeedClient = AutograderServiceClient(channel: channel)
    }
    
    func shutdown() {
        // Close the connections when we're done with it.
        try! self.channel.close().wait()
        try! self.eventLoopGroup.syncShutdownGracefully()
    }
}
