//
//  RequestAdapter.swift
//  FoxOne
//
//  Created by moubuns on 2018/9/5.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation
import Alamofire

let foxCustomPinHeader: String = "fox-client-pin"
let foxCustomKeyHeader: String = "fox-client-key"

class RequestAuthAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(PaySDK.shared.baseURL) {
            if let accessToken = PaySDK.shared.delegate?.f1AccessToken() {
                urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            }

            let header: [String: String]
            if let f1Header = PaySDK.shared.delegate?.f1HttpHeader?() {
                header = f1Header
            } else {
                let buildVersion = "0"
                let appVersion = PaySDK.shared.defalutConfig.sdkVerison
                let clientType = "5"
                let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""

                header = [
                    "x-client-build": buildVersion,
                    "x-client-type": clientType,
                    "x-client-version": appVersion,
                    "x-client-device-id": uuid
                ]
            }

            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }
}
