//
//  PaySDK.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/30.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

@objc
public protocol PaySDKProtcol: NSObjectProtocol {
    /// AccessToken
    func f1AccessToken() -> String

    /// PIN
    func f1PIN() -> String

    /// PIN加密使用的公钥匙
    @objc optional func f1PublicKey() -> String

    /// FoxOne API地址，选配
    @objc optional func f1HostURLString() -> String

    /// FoxOne 定制请求Header，选配
    @objc optional func f1HttpHeader() -> [String: String]
}

public final class PaySDK {
    public static let shared = PaySDK()
    internal var defalutConfig = SDKConfig()

    public var publicKey: String {
        guard let pubKey = self.delegate?.f1PublicKey?() else {
            return defalutConfig.env.defaultPublicKey
        }
        return pubKey

    }
    internal var baseURL: String {
        guard let url = self.delegate?.f1HostURLString?() else {
            return defalutConfig.env.serverApi
        }

        return url
    }

    internal var appKey: String?

    public weak var delegate: PaySDKProtcol?

    /// 注册 PaySDK
    public static func registerSDK(key: String, delegate: PaySDKProtcol, env: SDKEnviroment = .product) {
        PaySDK.shared.appKey = key
        PaySDK.shared.delegate = delegate
        PaySDK.shared.defalutConfig.env = env
    }
}
