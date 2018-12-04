//
//  WalletCoin.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/25.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

/// Fox.ONE Coin
public struct WalletCoin: Codable {
    /// Fox.ONE Coin Id
    public let id: Int
    /// logo
    public let logo: String
    /// mixin id
    public let mixinAssetId: String
    /// Symbol
    public let symbol: String
    /// 名称
    public let name: String
}
