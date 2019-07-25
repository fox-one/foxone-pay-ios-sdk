//
//  WalletCoin.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/25.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

public struct WalletAsset: Codable {
    public let assetId: String
    public let name: String
    public let symbol: String
    public let chainId: String
    public let icon: String
    public let price: Double
    public let priceUSD: Double
    public let priceBTC: Double
    public let changeUSDPercentage: Double
    public let changeBTCPercentage: Double
    public let changeCNYPercentage: Double
    public let confirmations: Int

}
