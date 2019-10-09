//
//  Snapshot.swift
//  FoxOne
//
//  Created by moubuns on 2018/6/26.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

/// 交易记录
public struct Snapshot: Codable {

    /// 资产ID
    public let assetId: String

    /// 金额
    public let amount: String

    /// 创建时间
    public let createAt: TimeInterval

    /// 备注
    public let memo: String

    /// 交易记录Id
    public let snapshotId: String

    /// 唯一标识
    public let traceId: String

    /// 外部转账
    public let transactionHash: String

    /// 发送方或接收方的 mixinId
    public let opponentId: String

    /// 接收方
    public let receiver: String

    /// 发送方
    public let sender: String

    /// 交易记录类型
    public let source: String

    /// 三方用户ID
    public let userId: String

    /// 发送方或接收方的 mixinId
    public let opponent: Opponent?

    /// 资产类型
    public let asset: Asset?
}
