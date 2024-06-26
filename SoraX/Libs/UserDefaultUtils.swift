//
//  UserDefaultUtils.swift
//  MarkupAssistant
//
//  Created by apple on 5/31/20.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

struct UserDefaultKey {
    static let userSearchHistory = "userSearchHistory"
    static let user = "user"
    static let searchCount = "searchCount"
    static let deviceID = "deviceID"
    static let AuthViewViewed = "AuthViewViewed"
    static let businessRate = "businessRate"
    static let gjjRate = "gjjRate"
    static let isDelayVip = "isDelayVip"
}

class UserDefaultUtils {
    // Shared Instance for the class
    static let shared = UserDefaultUtils()

    // Don't allow instances creation of this class
    private init() {}

    func saveObject<T: Codable>(_ object: T, _ key: String) {
        let dataEncoder = JSONEncoder()
        do {
            let data = try dataEncoder.encode(object)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            assertionFailure("Error encoding object of type \(T.self): \(error)")
        }
    }

    func fetchObject<T>(_ key: String) -> T? where T: Decodable {
        guard let savedItem = UserDefaults.standard.object(forKey: key) as? Data else { return nil}
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: savedItem)
        } catch {
            print("Error encoding object of type \(T.self): \(error)")
        }
        return nil
    }

    func appendStringToArray(_ key: String, _ string: String) {
        if var array: [String] = fetchObject(key) {
            array.append(string)
            saveObject(array, key)
        } else {
            let array = [string]
            saveObject(array, key)
        }
    }

    func removeStringFromArray(_ key: String, _ string: String) {
        if var array: [String] = fetchObject(key) {
            array = array.filter { $0 != string }
            saveObject(array, key)
        }
    }

    func removeObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    func saveItem(_ item: Any, _ key: String) {
        UserDefaults.standard.set(item, forKey: key)
    }

    func fetchItem(_ key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func isAuthViewViewed() -> Bool {
//        guard UserDefaultUtils.shared.fetchItem(UserDefaultKey.AuthViewViewed) != nil else {
//            return false
//        }
        return true
    }
    
    func isAuthed() -> Bool {
        guard UserDefaultUtils.shared.fetchItem(UserDefaultKey.deviceID) != nil else {
            return false
        }
        return true
    }
}

