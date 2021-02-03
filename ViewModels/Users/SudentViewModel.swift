//
//  SudentViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation


class StudentViewModel: UserViewModelProtocol, ObservableObject{
    var provider: ProviderProtocol
    @Published var user: User
    
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.user = provider.getUser() ?? User()
    }
    func reset() {
        
    }
    
    func changeName() {
        self.provider.changeName(newName: "test name")
        
        //self.user = provider.getUser() ?? User()
        
    }
    func getUser(){
        self.user = provider.getUser() ?? User()
    }
    
    
}

