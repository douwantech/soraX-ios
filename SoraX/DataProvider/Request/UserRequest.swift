//
//  UserRequest.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

class UserDataRequest: JsonRequest<User> {
    init() {
        super.init(method: .get, urlPath: "\(APIConst.BaseUrl)/api/v1/users")
        let queryParams = [String: String]()
        //queryParams["device_id"] = User.current().id
        setQueryParams(queryParams)
    }
    
    override func needsAccessToken() -> Bool {
        return true
    }
}

class UserUpdateRequest: JsonRequest<User> {
    init(vipDays: Int) {
        super.init(method: .put, urlPath: "\(APIConst.BaseUrl)/api/v1/users")
        var queryParams = [String: String]()
        //queryParams["device_id"] = User.current().id
        queryParams["vip_days"] = "\(vipDays)"
        setQueryParams(queryParams)
    }
    
    override func needsAccessToken() -> Bool {
        return false
    }
}

class UserAuthRequest: JsonRequest<AuthUser> {
    init(provider: String, token: String, deviceID: String) {
        super.init(method: .post, urlPath: "\(APIConst.BaseUrl)/api/v1/auth/\(provider)")
        var queryParams = [String: Any]()
        queryParams["token"] = token
        queryParams["device_id"] = deviceID
        setBody(queryParams)
    }
    
    override func needsAccessToken() -> Bool {
        return true
    }
}
