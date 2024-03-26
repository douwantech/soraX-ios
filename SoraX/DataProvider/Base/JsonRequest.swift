//
//  JsonRequest.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import Foundation

class JsonRequest<T: Codable>: BaseRequest {
    override func parseNetworkResponse(_ response: Any) -> Any? {
        guard let res = response as? Data else { return nil }
        return DecodingUtils.decodeData(res, to: T.self)
    }
}

class DecodingUtils {
    static func decodeData<T: Decodable>(_ data: Data, to type: T.Type) -> T? {
        let decoder = JSONDecoder()
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(df)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding \(T.self): \(error)")
        }
        return nil
    }
}
