//
//  ResultViewModel.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 24/02/2021.
//

import Foundation
import Combine

class ResultViewModel: ObservableObject{
    @Published var users: [User] = []
    @Published var isDisplayingSubmission: Bool = false
    @Published var selectedCourse: Course
    
    private var provider: ProviderProtocol
    
    
    init(provider: ProviderProtocol = FakeProvider(), courseId: UInt64) {
        self.provider = provider
        self.selectedCourse = provider.getCourse(courseId: courseId) ?? Course()
        self.users = provider.getUsersForCourse(course: selectedCourse)
        
    }
    
    
}
