//
//  UserViewModelProtocol.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 03/02/2021.
//


import Foundation

protocol UserViewModelProtocol: ObservableObject{
    //var user: User {get set}
    func reset()
}
