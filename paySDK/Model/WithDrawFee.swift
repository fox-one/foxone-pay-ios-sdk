//
//  WithDrawFee.swift
//  FoxOnePaySDK
//
//  Created by 孟文龙 on 2019/5/22.
//  Copyright © 2019 FoxOne. All rights reserved.
//

import Foundation

public struct WithDrawFee: Codable {
    // Fox.ONE CoinID
    public let feeAsset: Asset?
    // 资产ID
    public let feeAmount: String
    // 金额
    public let fee: Fee?
}
