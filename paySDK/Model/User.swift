import Foundation

/// 用户
public struct User: Codable {
    /// 用户ID
    public let id: String

    // 头像
    public let avatar: String

    // 邮箱
    public let email: String

    // 名称
    public let name: String

    // 是否激活
    public let isActive: Bool

    // 是否设置过PIN
    public let isPinSet: Bool

    // PIN类型
    public let pinType: Int
}
