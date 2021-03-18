//
//  HelpFunctions.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import Foundation

func matchesQuery(searchQuery: String, course: Course) -> Bool{
    if searchQuery == ""{
        return true
    }
    
    if course.code.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if course.name.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if course.tag.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if String(course.year).lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    return false
}

func matchesQuery(searchQuery: String, user: User) -> Bool{
    if searchQuery == ""{
        return true
    }
    
    if  user.name.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if  user.email.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if user.studentID.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    if user.login.lowercased().contains(searchQuery.lowercased()){
        return true
    }
    
    
    return false
}