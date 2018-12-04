//
//  Fee.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/28.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

/// 小费
public struct Fee: Codable {
    // Fox.ONE CoinID
    public let coinId: Int
    // 资产ID
    public let assetId: String
    // 金额
    public let amount: Double

}
