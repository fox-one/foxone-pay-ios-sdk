import Foundation

public class PinHelper {
    /// 生成PIN未混淆的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    public static func generatePinToken(with pin: String) -> String {
        return SecureData(key: pin).jsonString?.rsaToken ?? ""
    }

    public static func generateConfusionPinToken(with pin: String) -> String {
        return SecureData(hashPin: pin).jsonString?.rsaToken ?? ""
    }
}
