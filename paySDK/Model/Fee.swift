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
    // 资产 Symbol
    public let assetSymbol: String
    // 资产 ID
    public let assetId: String
    // 金额
    public let amount: String
}
