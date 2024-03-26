//
//  MyError.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import UIKit

class MyError: Codable, Error {
    public var message: String?

    private enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(message: String) {
        self.message = message
    }
}
