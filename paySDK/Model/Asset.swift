//
//  Asset.swift
//  FoxOne
//
//  Created by moubuns on 2018/6/26.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

/// 资产
public struct Asset: Codable {
    // ID
    public let assetId: String
    // 余额
    public let balance: Double
    // 主链ID
    public let chainId: String
    // 图标
    public let icon: String
    // 名称bre
    public let name: String
    // 当前价格 rmb计价
    public let price: Double
    // 当前价格 btc计价
    public let priceBTC: Double
    // 当前价格 usd计价
    public let priceUSD: Double
    // 公钥
    public let publicKey: String
    // 符号
    public let symbol: String
    // 价格变化，RMB计价
    public let changeRMBPercentage: Double
    // 价格变化，BTC计价
    public let changeBTCPercentage: Double
    // 价格变化，USD计价
    public let changeUSDPercentage: Double
    // EOS 账户名称
    public let accountName: String
    // EOS 账户标识
    public let accountTag: String
    // 主链
    public let chain: WalletAsset?
    // 显示选项
    public let option: Option
}
