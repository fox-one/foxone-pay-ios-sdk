import Foundation

public struct WithDrawFee: Codable {
    // Fox.ONE CoinID
    public let feeAsset: Asset?
    // 资产ID
    public let feeAmount: String
    // 金额
    public let fee: Fee?
}
