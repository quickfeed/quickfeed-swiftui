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

func date(date: String) -> String{
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let dateString = dateFormat.date(from: date)!
    
    let stringFormatter = DateFormatter()
    stringFormatter.dateFormat = "E, d MMM YY HH:mm"
    return stringFormatter.string(from: dateString)
}


func getReview(reviews: [Review]) -> [String]? {
    var feedback: [String] = []
    for review in reviews {
        if review.feedback.count != 0 {
            feedback.append(review.feedback)
        }
    }
    if feedback.count != 0 {
        return feedback
    }
    return nil
}

func getReadyReviews(reviews: [Review]) -> [Review]{
    var readyReviews: [Review] = []
    for review in reviews{
        if review.ready{
            readyReviews.append(review)
        }
    }
    return readyReviews
}
