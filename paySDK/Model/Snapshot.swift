//
//  Snapshot.swift
//  FoxOne
//
//  Created by moubuns on 2018/6/26.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

/// 交易记录类型
///
/// - deposit_confirmed: 充值
/// - transfer_initialized: 转账
/// - withdrawal_initialized: 提现
/// - withdrawal_fee_charged: 提现手续费
/// - withdrawal_failed: 提现失败

/// - o1_open_account: Ocean.ONE 账户开通
/// - o1_put_order: Ocean.ONE 下单
/// - o1_cancel_order: Ocean.ONE 撤单
/// - o1_order_refund: Ocean.ONE 订单退回
/// - o1_order_canceled: Ocean.ONE 订单取消
/// - o1_order_matched: Ocean.ONE 订单成交

public enum SnapshotType: String {
    case deposit_confirmed = "DEPOSIT_CONFIRMED"
    case transfer_initialized = "TRANSFER_INITIALIZED"
    case withdrawal_initialized = "WITHDRAWAL_INITIALIZED"
    case withdrawal_fee_charged = "WITHDRAWAL_FEE_CHARGED"
    case withdrawal_failed = "WITHDRAWAL_FAILED"
    case o1_open_account = "O1_OPEN_ACCOUNT"
    case o1_put_order = "O1_PUT_ORDER"
    case o1_cancel_order = "O1_CANCEL_ORDER"
    case o1_order_refund = "O1_ORDER_REFUND"
    case o1_order_canceled = "O1_ORDER_CANCELED"
    case o1_order_matched = "O1_ORDER_MATCHED"
    case fox_redpacket_pay = "FOX_REDPACKET_PAY"
    case fox_redpacket_reward = "FOX_REDPACKET_REWARD"
    case fox_redpacket_refund = "FOX_REDPACKET_REFUND"
}

/// 交易记录
public struct Snapshot: Codable {

    /// 资产ID
    public let assetId: String

    /// 金额
    public let amount: Double

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
