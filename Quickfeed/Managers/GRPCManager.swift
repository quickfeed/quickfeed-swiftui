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
        // Setup an `EventLoopGroup` for the connection to run on.
        //
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        // Configure the channel, we're not using TLS so the connection is `insecure`.
        //self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
        //.connect(host: "https://ag2.ux.uis.no", port: 3005)
        
        
        
        self.channel = ClientConnection.insecure(group: self.eventLoopGroup)
            .connect(host: "ag2.ux.uis.no", port: 443)
        
        
        print("GRPC connection")
        
        
        // Provide the connection to the generated client.
        self.quickfeedClient = AutograderServiceClient(channel: channel)
        //self.quickfeedClient = setUpTLS()
        
    }
    
    
    func getProviders(){
        let call = self.quickfeedClient.getProviders(Void())
        
        
        
        do {
            print("getting providers")
            
            print("connectivity state: \(self.channel.connectivity.state)")
            let response = try call.response.wait()
            
            
            print("Call received: \(response.providers)")
        } catch {
            print("Call failed: \(error)")
        }
        
        
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


func setUpTLS() -> AutograderServiceClient{
    //Step i: get certificate path from Bundle
    let hostname = "ag2.ux.uis.no"
    let port = 443
    
    let certificatePath = Bundle.main.path(forResource: "certificateName", ofType: "pem")
    //Step ii: create TLS configuration
    
    var configuration = TLSConfiguration.forClient(applicationProtocols: ["h2"])
    configuration.trustRoots = .file(certificatePath!) //anchors the ca certificate to trust roots for TLS configuration. Not required incase of insecure communication with host
    //Step iii: generate SSL context
    do {
        let sslContext = try NIOSSLContext(configuration: configuration)
        let handler = try NIOSSLClientHandler(context: sslContext, serverHostname: hostname + "\(port)")
        
    } catch{
        print("Call failed: \(error)")
    }
    
    
    //Step iv: Create an event loop group
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    //Step v: Create client connection builder
    let builder: ClientConnection.Builder
    builder = ClientConnection.secure(group: group).withTLS(trustRoots: configuration.trustRoots!)
    //Step vi: Start the connection and create the client
    let connection = builder.connect(host: hostname, port: port)
    print("Connection Status=>:\(connection)")
    //Step vii: Create client
    //use appropriate service client from .grpc server to replace the xxx call : <your .grpc.swift ServiceClient> = <XXX>ServiceClient
    let qfClient = AutograderServiceClient(channel: connection)
    
    return qfClient
    
    
}
