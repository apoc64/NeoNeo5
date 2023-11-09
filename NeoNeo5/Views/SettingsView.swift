//
//  SettingsView.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI

struct SettingsViewModel {
    let username: String
}

struct SettingsView: View {
    @ObservedObject var model = UserSettings()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $model.username)
                    Toggle(isOn: $model.isPrivate) {
                        Text("Private Account")
                    }
                }
                
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle(isOn: $model.notificationsEnabled) {
                        Text("Enabled")
                    }
                    Picker(selection: $model.previewIndex, label: Text("Show Previews")) {
                        ForEach(0 ..< model.previewOptions.count) {
                            Text(model.previewOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("ABOUT")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(model.version)
                    }
                }
                
                Section {
                    Button(action: resetAllSettings) {
                        Text("Reset All Settings")
                    }
                }
            }.navigationBarTitle("Settings")
        }
    }
    
    func resetAllSettings() {
        model.resetAllSettings()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
