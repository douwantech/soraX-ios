//
//  NetworkDataProvider.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import Foundation

final class NetworkDataProvider: DataProvider {
    func userData(_ completionHandler: CompletionHandler?) {
        self.processRequest(UserDataRequest(), completionHandler)
    }
    
    func userUpdate(vipDays: Int, _ completionHandler: CompletionHandler?) {
//        self.processRequest(UserUpdateRequest(vipDays: vipDays), completionHandler)
    }
    
    func userAuth(provider: String, token: String, deviceID: String, _ completionHandler: CompletionHandler?) {
        self.processRequest(UserAuthRequest(provider: provider, token: token, deviceID: deviceID), completionHandler)
    }
    
    // MARK: - Private methods
    private func processRequest(_ request: BaseRequest,_ completionHandler: CompletionHandler?) -> Void {
        self.executeRequest(request, completionHandler)
    }
    
    private func executeRequest(_ request: BaseRequest,_ completionHandler: CompletionHandler?) -> Void {
        if request.needsAccessToken() {
            /*
             * Set the Access Token to the request header.
             */
            request.setAccessToken()
        }
        
        NetworkProvider.shared.sendRequest(request) {(_ data: Any, _ error: Error?) in
            completionHandler?(data, error)
        }
    }
}
