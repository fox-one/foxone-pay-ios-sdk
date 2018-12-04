//
//  CNYTicker.swift
//  FoxOne
//
//  Created by moubuns on 2018/10/10.
//

import Foundation

public struct CNYTicker: Codable {
    // 24小时变化率
    public let changeIn24h: String
    // 币种
    public let from: String
    // 币种
    public let to: String
    // 价格
    public let price: String
    // 时间戳
    public let timestamp: TimeInterval

}
