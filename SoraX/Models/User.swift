//
//  User.swift
//  FaceSwap
//
//  Created by apple on 8/10/23.
//

import UIKit

class AuthUser: Codable {
    var deviceID: String = ""
    var userTotalCredit: Int = 0
    var vipTotalCredit: Int = 0
    var userFreeCredit: Int = 0
    var refillPackCredit: Int = 0
    var accessToken: String = ""

    private enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
        case userTotalCredit = "user_total_credit"
        case vipTotalCredit = "vip_total_credit"
        case userFreeCredit = "user_free_credit"
        case refillPackCredit = "refill_pack_credit"
        case accessToken = "access_token"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let deviceID = try? container.decode(.deviceID) as String {
            self.deviceID = deviceID
        }
        self.userTotalCredit = (try? container.decode(.userTotalCredit) as Int) ?? 0
        self.vipTotalCredit = (try? container.decode(.vipTotalCredit) as Int) ?? 0
        self.userFreeCredit = (try? container.decode(.userFreeCredit) as Int) ?? 0
        self.refillPackCredit = (try? container.decode(.refillPackCredit) as Int) ?? 0
        self.accessToken = (try? container.decode(.accessToken) as String) ?? ""
    }

    init() {}
}

class User: Codable {
    var id: String = ""
    var vipDays: Int = 0
    var deviceID: String = ""
    var accessToken: String = ""
    var authed: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case vipDays = "vip_days"
        case deviceID = "device_id"
        case accessToken = "access_token"
        case authed
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? container.decode(.id) as String {
            self.id = id
        }
        if let accessToken = try? container.decode(.accessToken) as String {
            self.accessToken = accessToken
        }
        if let authed = try? container.decode(.authed) as Bool {
            self.authed = authed
        }
        self.deviceID = (try? container.decode(.deviceID) as String) ?? ""
        self.vipDays = (try? container.decode(.vipDays) as Int) ?? 0
    }
    
    init() {}
    
    static var _current: User?
    
    class func current() -> User {
        if _current != nil { return _current! }
        let user: User? = UserDefaultUtils.shared.fetchObject(UserDefaultKey.user)
        if user != nil {
            _current = user
            return _current!
        }
        _current = User()
        _current!.id = UUID().uuidString
        UserDefaultUtils.shared.saveObject(_current, UserDefaultKey.user)
        return _current!
    }
    
    
    func makeAsVip(vipDays: Int) {
        let current = User.current()
        current.vipDays = vipDays
        UserDefaultUtils.shared.saveObject(current, UserDefaultKey.user)
    }
    
    
    func saveToCurrent() {
        let current = User.current()
        current.deviceID = self.deviceID
        UserDefaultUtils.shared.saveObject(current, UserDefaultKey.user)
    }
    
    func markAsLogin(authUser: AuthUser) {
        let current = User.current()
        current.accessToken = authUser.accessToken
        current.deviceID = authUser.deviceID
        current.authed = true
        UserDefaultUtils.shared.saveObject(current, UserDefaultKey.user)
    }
    
    func markAsLogout() {
        let current = User.current()
        current.accessToken = ""
        current.authed = false
        UserDefaultUtils.shared.saveObject(current, UserDefaultKey.user)
    }
    
    class func syncData(){
        DataManager.dataProvider.userData { (data, error) in
            if error != nil { return }
            
            if let user = data as? User {
                user.saveToCurrent()
            }
        }
    }
    
    public func makeAsVip(deviceID: String, vipDays: Int) {
        let current = User.current()
        current.deviceID = deviceID
        current.vipDays = vipDays
        UserDefaultUtils.shared.saveObject(current, UserDefaultKey.user)
    }
    
    class func isLogin() -> Bool {
        return User.current().authed
    }
}

