//
//  TeacherViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//

import Foundation
import Combine

class TeacherViewModel: UserViewModelProtocol{
    var user: User
    
    
    init(user: User) {
        self.user = user
    }
    
    func reset() {
        
    }
    
    
}
