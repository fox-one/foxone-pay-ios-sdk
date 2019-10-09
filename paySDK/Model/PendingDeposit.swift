//
//  PendingDeposit.swift
//  FoxOnePaySDK
//
//  Created by moubuns on 2019/8/21.
//

import Foundation

public struct PendingDeposit: Codable {
    public let amount: String
    public let assetId: String
    public let chainId: String
    public let confirmations: Int
    public let createdAt: Double
    public let publicKey: String
    public let threshold: Int
    public let transactionHash: String
    public let transactionId: String
    public let type: String
}
