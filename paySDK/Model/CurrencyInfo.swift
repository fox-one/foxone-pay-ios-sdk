//
//  CurrenyInfo.swift
//  FoxOne
//
//  Created by moubuns on 2018/10/10.
//

import Foundation
// 汇率信息
public struct CurrencyInfo {
    // 币种汇率
    public let cnyTickers: [CNYTicker]
    // USD USDT
    public let currency: Currency?
}
