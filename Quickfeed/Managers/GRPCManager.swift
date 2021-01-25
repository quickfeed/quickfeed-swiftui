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
    let quickfeedClient: AutograderServiceClient
    
    init(){
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        let channel = ClientConnection.insecure(group: group)
          .connect(host: "http://5ba8fa169816.ngrok.io", port: 80)

        self.quickfeedClient = AutograderServiceClient(channel: channel)
    }
}
