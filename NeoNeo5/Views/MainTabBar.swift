//
//  MainTabBar.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView{
            NeoListView()
                .tabItem {
                    Image(systemName: "star.slash")
                    Text("NEOs")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.accentColor(.red)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
