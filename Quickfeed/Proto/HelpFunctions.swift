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
