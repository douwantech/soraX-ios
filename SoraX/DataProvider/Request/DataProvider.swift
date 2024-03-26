//
//  DataProvider.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import Foundation
protocol DataProvider {
    func userData(_ completionHandler: CompletionHandler?)
    func userUpdate(vipDays: Int, _ completionHandler: CompletionHandler?)
    func userAuth(provider: String, token: String, deviceID: String, _ completionHandler: CompletionHandler?)
}
