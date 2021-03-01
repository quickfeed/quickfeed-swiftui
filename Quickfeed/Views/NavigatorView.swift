//
//  NavigatorView.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 26/02/2021.
//

import SwiftUI

struct NavigatorView: View {
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                NavigationLink(
                    destination: Text("Destination")){
                    Text("TEST")
                }
                Spacer()
                NavigationLink(
                    destination: Text("UserProfile_HardCoded")){
                    Image(systemName: "person.fill")
                    Text("Bjørn Kristian Teisrud")
                }
            }
        }
    }
}

struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView(selectedCourse: 111)
    }
}
