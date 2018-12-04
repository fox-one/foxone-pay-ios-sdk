//
//  PaySDKEnviroment.swift
//  FoxOne
//
//  Created by moubuns on 2018/10/24.
//

import Foundation

public enum SDKEnviroment: Int {
    case dev
    case product
    
    var serverApi: String {
        switch self {
        case .dev:
            return "http://dev.fox.one/api"
        case .product:
            return "https://api.kumiclub.com/api"
        }
    }
    
    var defaultPublicKey: String {
        switch self {
        case .dev:
            return debugPublicKey
        case .product:
            return productKey
        }
    }
}
