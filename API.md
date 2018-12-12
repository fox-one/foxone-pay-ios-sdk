#  PaySDKProtcol


```swift
protocol PaySDKProtcol : NSObjectProtocol {

    /// AccessToken
    func f1AccessToken() -> String
    
    /// PIN
    func f1PIN() -> String

    /// PIN加密使用的公钥匙
    func f1PublicKey() -> String

    /// FoxOne 钱包地址
    func f1HostURLString() -> String

    /// FoxOne 后端请求Header
    func f1HttpHeader() -> [String : String]
}
```


```swift
class PaySDK {
    /// 注册OpenSDK
    static func setDelegate(_ delegate: PaySDKProtcol)

    /// 生成PIN混淆之后的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    class func generateConfusionPinToken(pin: String) -> String

    /// 生成PIN未混淆的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    class func generatePinToken(with pin: String) -> String
}

```


```swift

class PaySDKService {

    /// 获取用户的资产的列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，所有资产或者错误
    /// - Returns: 返回请求体
    class func getAssets(completion: @escaping (Result<[Asset]>) -> Void) -> DataRequest

    /// 获取指定的数字资产
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: assetId: 资产ID
    ///   - completion: 结果回调，数字资产或者错误
    /// - Returns: 返回请求体
    class func getAsset(with id: String, completion: @escaping (Result<Asset>) -> Void) -> DataRequest

    /// 获取指定资产的交易记录
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    class func getSnapshot(with id: String, cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo)>) -> Void) -> DataRequest

    class func hideAsset(by id: String, hide: Bool, completion: @escaping (Result<Void>) -> Void) -> DataRequest

    /// 获取所有交易记录列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    class func getSnapshots(cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo)>) -> Void) -> DataRequest

    /// 获取指定交易记录Id的交易记录
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    class func getSnapshot(with id: String, completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest

    /// 获取钱包支持资产的列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，返回资产列表或者错误
    /// - Returns: 返回请求体
    class func getSupportAssets(completion: @escaping (Result<[Asset]>) -> Void) -> DataRequest

    /// 转账
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - address: 接收地址
    ///   - amount: 转账数量
    ///   - assetId: 资产ID
    ///   - memo: 备注
    ///   - label: 标签用于EOS
    ///   - completion: 结果回调，返回交易记录或者错误
    /// - Returns: 返回请求体
    class func withdraw(to address: String, amount: String, assetId: String, memo: String, label: String, completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest

    /// 转账
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - address: 接收用户ID
    ///   - amount: 转账数量
    ///   - assetId: 资产ID
    ///   - memo: 备注
    ///   - completion: 结果回调，返回交易记录或者错误
    /// - Returns: 返回请求体
    class func transfer(to userId: String, amount: String, assetId: String, memo: String, completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest

    /// 获取转账手续费
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - address: 接收地址
    ///   - label: 标签用于EOS
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    class func getFee(by id: String, address: String, label: String, completion: @escaping (Result<Fee>) -> Void) -> DataRequest

    /// 设置PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - newPin: PIN
    ///   - type: Pin类型
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    class func setPin(newPin: String, type: Int = default, completion: @escaping (Result<Void>) -> Void) -> DataRequest

    /// 修改PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - oldPin: 老的PIN
    ///   - oldPin: 新的PIN
    ///   - type: 类型
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    class func changePin(oldPin: String, newPin: String, type: Int = default, completion: @escaping (Result<Void>) -> Void) -> DataRequest

    /// 校验PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - pin: PIN
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    class func validatePin(pin: String, completion: @escaping (Result<Void>) -> Void) -> DataRequest

    /// 获取汇率
    ///
    /// - Parameter completion: 汇率信息
    /// - Returns: 返回请求体
    class func getCurrency(completion: @escaping (Result<CurrencyInfo>) -> Void) -> DataRequest

    /// 获取公钥
    ///
    /// - Parameter completion: 公钥
    /// - Returns: 返回请求体
    internal class func getConfig(completion: @escaping (Result<String>) -> Void) -> DataRequest

    /// 获取用户信息
    ///
    /// - Parameter completion: 用户
    /// - Returns: 返回请求体
    class func getUser(completion: @escaping (Result<User>) -> Void) -> DataRequest
}

```
