//
//  Network.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/31.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkManager {
    static let shared = NetworkManager()
    private let sessionManager = SessionManager()

    init() {
        sessionManager.adapter = RequestAuthAdapter()
    }

    func request(api: PaySDKAPI) -> DataRequest {
        return sessionManager
            .request(api.url,
                     method: api.method,
                     parameters: api.parameters,
                     encoding: api.parameterEncoding,
                     headers: api.headers)
            .validate({ _, response, data -> Request.ValidationResult in
                var acceptableStatusCodes: [Int] {
                    return Array(200..<300)
                }
                
                if acceptableStatusCodes.contains(response.statusCode) {
                    return .success
                } else {
                    guard let data = data else {
                        return .failure(ErrorCode.dataError)
                    }
                    
                    let json = JSON(data)
                    let statusCode = json["code"].intValue
                    return .failure(PaySDKError.error(code: statusCode, message: ErrorCode.errorMessage(for: statusCode) ?? json["msg"].stringValue))
                }
            })
    }
}
