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
