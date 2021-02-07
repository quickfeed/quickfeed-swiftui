//
//  StudentViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation


class StudentViewModel: UserViewModelProtocol{
    var provider: ProviderProtocol
    @Published var user: User
    
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
    }
    func reset() {
        
    }
    
  
    func getUser(){
        self.user = provider.getUser() ?? User()
    }
    
    
}
