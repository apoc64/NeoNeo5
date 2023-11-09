//
//  NeoNeo5App.swift
//  NeoNeo5
//
//  Created by Steven Schwedt on 11/9/23.
//

import SwiftUI

@main
struct NeoNeo5App: App {

    init() {
        Container.register(DataTaskPublishing.self) { _ in URLSession.shared }
    }

    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
    }
}
