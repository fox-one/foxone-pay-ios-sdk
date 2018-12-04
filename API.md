#  OpenSDKProtcol


```
public protocol OpenSDKProtcol : NSObjectProtocol {

    /// AccessToken
    public func f1AccessToken() -> String

    /// PIN加密使用的公钥匙
    public func f1PublicKey() -> String

    /// FoxOne 钱包地址
    public func f1HostURLString() -> String

    /// FoxOne 后端请求Header
    public func f1HttpHeader() -> [String : String]
}
```


```
public final class OpenSDK {
    /// 注册OpenSDK
    public static func setDelegate(_ delegate: OpenSDKProtcol)

    /// 生成PIN混淆之后的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    public class func generateConfusionPinToken(pin: String) -> String

    /// 生成PIN未混淆的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    public class func generatePinToken(with pin: String) -> String
}

```


```
public final class OpenSDKService {

    /// 获取所有资产的列表
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，所有资产或者错误
    /// - Returns: 返回请求体
    public class func getAssets(completion: (Result<[Asset]>) -> Void) -> DataRequest

    /// 获取制定的数字资产
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: assetId: 资产ID
    ///   - completion: 结果回调，数字资产或者错误
    /// - Returns: 返回请求体
    public class func getAsset(with id: String, completion: (Result<Asset>) -> Void) -> DataRequest

    /// 获取指定资产的交易记录
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    public class func getSnapShot(with id: String, completion: (Result<[Snapshot]>) -> Void) -> DataRequest

    /// 获取所有交易记录列表
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    public class func getSnapshots(completion: (Result<[Snapshot]>) -> Void) -> DataRequest

    /// 获取可用币种的的地址列表
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，返回币种列表或者错误
    /// - Returns: 返回请求体
    public class func getWalletCoin(completion: (Result<[WalletCoin]>) -> Void) -> DataRequest

    /// 转账
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - address: 接收地址
    ///   - amount: 转账数量
    ///   - assetId: 资产ID
    ///   - memo: 备注
    ///   - label: 标签用于EOS
    ///   - completion: 结果回调，返回交易记录或者错误
    /// - Returns: 返回请求体
    public class func withdrawTo(address: String, amount: String, assetId: String, memo: String, label: String, completion: (Result<Snapshot>) -> Void) -> DataRequest

    /// 获取转账手续费
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - address: 接收地址
    ///   - label: 标签用于EOS
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    public class func getFee(with id: String, address: String, label: String, completion: (Result<Fee>) -> Void) -> DataRequest

    /// 设置PIN
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - newPinToken: PINToken
    ///   - type: Pin类型
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    public class func setPin(newPinToken: String, type: Int, completion: (Result<Bool>) -> Void) -> DataRequest

    /// 修改PIN
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - oldPinToken: 老的PINToken
    ///   - newPinToken: 新的PINToken
    ///   - type: 类型
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    public class func changePin(oldPinToken: String, newPinToken: String, type: Int, completion: (Result<Bool>) -> Void) -> DataRequest

    /// 校验PIN
    /// （必须在OPENSDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - pinToken: PINToken
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    public class func validatePin(pinToken: String, completion: (Result<Bool>) -> Void) -> DataRequest
}

```
