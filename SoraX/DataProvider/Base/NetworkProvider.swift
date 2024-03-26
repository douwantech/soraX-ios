//
//  NetworkProvider.swift
//  FaceSwap
//
//  Created by Mark on 2023/10/8.
//  Copyright © 2023 dongqiwang. All rights reserved.
//

import Foundation
import Alamofire

class NetworkProvider {
    
    static let shared = NetworkProvider()
    var alamofireManager: Alamofire.Session?
    
    // Don't allow instances creation of this class
    private init() {
        configureAlamofire()
    }
    
    func configureAlamofire() {
        let interceptor = AiAssistantRequestInterceptor()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        alamofireManager = Session(configuration: configuration, interceptor: interceptor)
    }

    /**
     * Sends a request to the backend and returns the response (or an error) through the
     * CompletionHandler received.
     *
     * @param baseRequest
     *      BaseRequest to send to the backend.
     * @param completionHandler
     *      CompletionHandler that will receive the response from this request.
     */
    func sendRequest(_ baseRequest: BaseRequest, _ completionHandler: CompletionHandler?) -> Void {
        
        self.alamofireManager?.request(baseRequest).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let completionHandler = completionHandler else { return }
                guard let res = response.data else { return }
                guard let jsonResponse = try? JSON(data: res) else { return }
                print(baseRequest.urlRequest.url ?? "", jsonResponse)
                if jsonResponse["success"].boolValue {
                    let data = try? jsonResponse["data"].rawData()
                    let allData = try? jsonResponse.rawData()
                    let responseData = baseRequest.parseNetworkResponse(data ?? allData ?? Data())
                    completionHandler(responseData, nil)
                } else {
                    completionHandler(nil, MyError(message: jsonResponse["message"].stringValue))
                }

                break
//                if let json = response.result {
//                }
            case .failure:
                guard let completionHandler = completionHandler else { return }
                completionHandler(nil, response.error)
                break
                /*// Instead of using response.result.error, intatiate our own McError to pass through CompletionHandler
                
                var mcError = McError()
                
                if let errorData = response.data {
                    let decoder = JSONDecoder()
                    if let error = try? decoder.decode(McError.self, from: errorData) {
                        mcError = error
                        Crashlytics.sharedInstance().recordError(mcError)
                    }
                }
                
                if let statusCode = (response.error as? AFError)?.responseCode {
                    mcError.statusCode = statusCode
                }

                // If the the server does not provide a specific error through response.data, we must set a generic error instead of returning nil:
                let  genericErrorMessage = H.t("common.error_response")
                
                if mcError.message == nil || 500...599 ~= mcError.statusCode ?? 500 {
                    mcError.message = genericErrorMessage
                }
                
                if let completionHandler = completionHandler {
                    completionHandler(baseRequest, mcError)
                }*/
            }
        }
    }
    
}

class RequestRetryHandler: RequestRetrier {
    let maxRetries: Int = 3
    open func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (Alamofire.RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 429,
            request.retryCount < maxRetries {
            /**
             * Add jitter to retry delay to stop multiple clients
             * from retrying at the same time
             */
            let jitter = Double.random(in: 0...1)
            completion(.retryWithDelay(2.0 + jitter)) // retry after interval between 2 - 3 seconds
        } else {
            completion(.doNotRetry) // don't retry
        }
    }
}

class AiAssistantRequestInterceptor: RequestInterceptor {
    let maxRetries: Int = 3
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let adaptedRequest = urlRequest
        // 进行任何适应请求的修改
        
        completion(.success(adaptedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 429,
            request.retryCount < maxRetries {
            /**
             * Add jitter to retry delay to stop multiple clients
             * from retrying at the same time
             */
            let jitter = Double.random(in: 0...1)
            completion(.retryWithDelay(2.0 + jitter)) // retry after interval between 2 - 3 seconds
        } else {
            completion(.doNotRetry) // don't retry
        }
    }
}
