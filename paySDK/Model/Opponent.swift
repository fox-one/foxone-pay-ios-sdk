import Foundation

/// 发送或接收方
public struct Opponent: Codable {
    /// Fox.ONE id
    public let foxId: Int

    /// Mixin id
    public let mixinId: String

    /// 头像
    public let avatar: String

    /// 用户名
    public let fullname: String
}
