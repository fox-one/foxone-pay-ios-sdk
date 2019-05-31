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
    public let changeRMBPercentage: Double

//    public init(price: Double, changeUsd: Double, assetID: String, chainID: String, name: String, symbol: String, icon: String, priceUSD: Double, priceBTC: Double, change: Double, changeBtc: Double) {
//        self.price = price
//        self.changeUSDPercentage = changeUsd
//        self.assetId = assetID
//        self.chainId = chainID
//        self.name = name
//        self.symbol = symbol
//        self.icon = icon
//        self.priceUSD = priceUSD
//        self.priceBTC = priceBTC
//        self.changeRMBPercentage = change
//        self.changeBTCPercentage = changeBtc
//    }
}
