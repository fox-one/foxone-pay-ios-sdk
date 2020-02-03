import Foundation

/// 资产
public struct Asset: Codable {
    // ID
    public let assetId: String
    // 余额
    public let balance: String
    // 主链ID
    public let chainId: String
    // 图标
    public let icon: String
    // 名称bre
    public let name: String
    // 当前价格 cny计价
    public let price: String
    // 当前价格 btc计价
    public let priceBTC: String
    // 当前价格 usd计价
    public let priceUSD: String
    // 符号
    public let symbol: String
    // 价格变化，CNY计价
    public let changeCNYPercentage: String
    // 价格变化，BTC计价
    public let changeBTCPercentage: String
    // 价格变化，USD计价
    public let changeUSDPercentage: String

    // 主链
    public let chain: WalletAsset?
    // 显示选项
    public let option: Option
    
    // Destination
    public let destination: String
    // Tag
    public let tag: String
}
