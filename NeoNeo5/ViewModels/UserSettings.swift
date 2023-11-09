//
//  UserSettings.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 7/24/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var username: String {
        didSet {
            userDefaults.set(username, forKey: keys.userNameKey)
        }
    }
    
    @Published var isPrivate: Bool {
        didSet {
            userDefaults.set(isPrivate, forKey: keys.isPrivateKey)
        }
    }
    
    @Published var notificationsEnabled: Bool {
        didSet {
            userDefaults.set(notificationsEnabled, forKey: keys.notificationsEnabledKey)
        }
    }
    
    @Published var previewIndex: Int {
        didSet {
            userDefaults.set(previewIndex, forKey: keys.previewOptionKey)
        }
    }
    
    var previewOptions = ["Always", "When Unlocked", "Never"]
    
    var version: String {
        Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? ""
    }
    
    func resetAllSettings() {
        username = ""
        isPrivate = true
        notificationsEnabled = false
        previewIndex = 0
    }
    
    private let keys: UserSettingsKeys
    
    private let userDefaults = UserDefaults.standard

    init(keys: UserSettingsKeys = UserSettingsKeys.defaultKeys) {
        self.keys = keys
        self.username = UserDefaults.standard.string(forKey: keys.userNameKey) ?? ""
        self.isPrivate = UserDefaults.standard.object(forKey: keys.isPrivateKey) as? Bool ?? true
        self.notificationsEnabled = UserDefaults.standard.object(forKey: keys.notificationsEnabledKey) as? Bool ?? false
        self.previewIndex = UserDefaults.standard.integer(forKey: keys.previewOptionKey)
    }
}

struct UserSettingsKeys {
    let userNameKey: String
    let isPrivateKey: String
    let notificationsEnabledKey: String
    let previewOptionKey: String
    
    static let defaultKeys = UserSettingsKeys(
        userNameKey: "userNameKEy",
        isPrivateKey: "isPrivateKey",
        notificationsEnabledKey: "notificationsEnabledKey",
        previewOptionKey: "previewOptionKey")
}
