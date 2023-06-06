//
//  TP2App.swift
//  TP2
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

@main
struct TP2App: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            //ContentView(movieid: 673)
            ListView().environmentObject(viewModel)
        }
    }
}
