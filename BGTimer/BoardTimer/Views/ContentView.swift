//
//  ContentView.swift
//  BoardTimer
//
//  Created by Sykomic on 2021/01/18.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            StartView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        Group {
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
            ContentView()
                .environment(\.locale, .init(identifier: "ko"))
            }
    }
}
