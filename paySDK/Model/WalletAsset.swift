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
    public let price: String
    public let priceUSD: String
    public let priceBTC: String
    public let changeUSDPercentage: String
    public let changeBTCPercentage: String
    public let changeCNYPercentage: String
    public let confirmations: Int

}
