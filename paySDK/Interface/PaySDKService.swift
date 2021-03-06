import Foundation
import SwiftyJSON
import Alamofire

public final class PaySDKService {

    /// 获取用户的资产的列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，所有资产或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getAssets(completion: @escaping (Result<[Asset], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared.request(api: PaySDKAPI.assets)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Asset], PaySDKError>) in
                    guard let mappedObject = Lists<Asset>(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }
                    return Result.success(mappedObject.items)
                })
    }

    /// 获取指定的数字资产
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: assetId: 资产ID
    ///   - completion: 结果回调，数字资产或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getAsset(with id: String, completion: @escaping (Result<Asset, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared.request(api: PaySDKAPI.asset(id: id))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Asset, PaySDKError>) in
                    guard let mappedObject = Asset(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })

    }

    /// 获取指定资产的交易记录
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getSnapshot(with id: String, cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo), PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.snapshot(id: id, cursor: cursor, limit: limit))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<([Snapshot], PageInfo), PaySDKError>) in
                    guard let mappedObject = Lists<Snapshot>(jsonData: json, key: "snapshots") else {
                        return Result.failure(ErrorCode.dataError)
                    }
                    return Result.success((snapshots: mappedObject.items, pagination: mappedObject.pagination))
                })
    }

    @discardableResult
    public class func hideAsset(by id: String, hide: Bool, completion: @escaping (Result<Void, PaySDKError>) -> Void) -> DataRequest {
        let request: DataRequest
        if hide {
            request = NetworkManager.shared.request(api: PaySDKAPI.hideAsset(id: id))
        } else {
            request = NetworkManager.shared.request(api: PaySDKAPI.showAsset(id: id))
        }

        return request.responseData(completionHandler: { response in
            switch response.result {
            case .success:
                completion(Result.success(()))
            case .failure(let _):
                completion(Result.failure(ErrorCode.dataError))
            }
        })
    }

    /// 获取所有交易记录列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getSnapshots(cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo), PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.snapshots(cursor: cursor, limit: limit))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<([Snapshot], PageInfo), PaySDKError>) in
                    guard let mappedObject = Lists<Snapshot>(jsonData: json, key: "snapshots") else {
                        return Result.failure(ErrorCode.dataError)

                    }
                    return Result.success((snapshots: mappedObject.items, pagination: mappedObject.pagination))
                })
    }

    /// 获取指定交易记录Id的交易记录
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getSnapshot(with id: String, completion: @escaping (Result<Snapshot, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.getSnapshot(id: id))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot, PaySDKError>) in
                    guard let mappedObject = Snapshot(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })
    }

    /// 获取钱包支持资产的列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，返回资产列表或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getSupportAssets(completion: @escaping (Result<[Asset], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.supportAssets)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Asset], PaySDKError>) in
                    guard let mappedObject = Lists<Asset>(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }
                    return Result.success(mappedObject.items)
                })
    }
    
    /// 转账给账户
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - destination: 接收地址
    ///   - amount: 转账数量
    ///   - assetId: 资产ID
    ///   - memo: 备注
    ///   - tag: 标签
    ///   - completion: 结果回调，返回交易记录或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func withdrawToDestination(to destination: String, tag: String,
                               amount: String,
                               assetId: String,
                               memo: String,
                               completion: @escaping (Result<Snapshot, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.withdrawToDestination(assetId: assetId, amount: amount, destination: destination, tag: tag, memo: memo))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot, PaySDKError>) in
                guard let mappedObject = Snapshot(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject)
            })
    }
    
    /// 转账给地址id
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
    @discardableResult
    public class func withdrawToAddress(to addressId: String,
                               amount: String,
                               assetId: String,
                               completion: @escaping (Result<Snapshot, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.withdrawToAddressId(assetId: assetId, amount: amount, addressId: addressId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot, PaySDKError>) in
                guard let mappedObject = Snapshot(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject)
            })
    }
    
    /// 转账给WalletID
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
    @discardableResult
    public class func withdrawToWallet(to walletId: String,
                               amount: String,
                               assetId: String,
                               completion: @escaping (Result<Snapshot, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.withdrawToWalletId(assetId: assetId, amount: amount, walletId: walletId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot, PaySDKError>) in
                guard let mappedObject = Snapshot(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject)
            })
    }


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
    @discardableResult
    public class func transfer(to userId: String,
                               amount: String,
                               assetId: String,
                               memo: String,
                               traceId: String? = nil,
                               completion: @escaping (Result<Snapshot, PaySDKError>) -> Void) -> DataRequest {
        let trace = traceId ?? UUID().uuidString
        return NetworkManager.shared
                .request(api: PaySDKAPI.transfer(opponentId: userId, assetId: assetId, memo: memo, amount: amount, traceId: trace.lowercased()))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot, PaySDKError>) in
                    guard let mappedObject = Snapshot(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })
    }

    /// 获取转账手续费
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - id: 资产ID
    ///   - destination: 接收地址
    ///   - tag: 标签用于EOS
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getFee(by id: String, destination: String, tag: String, completion: @escaping (Result<WithDrawFee, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.fee(assetId: id, destination: destination, tag: tag))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<WithDrawFee, PaySDKError>) in
                    guard let mappedObject = WithDrawFee(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })

    }

    /// 设置PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - newPin: PIN
    ///   - type: Pin类型
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func setPin(newPin: String, type: Int = 2, completion: @escaping (Result<Void, PaySDKError>) -> Void) -> DataRequest {
        let newPinToken = PinHelper.generateConfusionPinToken(with: newPin)
        return NetworkManager.shared
                .request(api: PaySDKAPI.setPin(newPinToken: newPinToken, type: type))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void, PaySDKError>) in
                    return Result.success(())
                })
    }

    /// 修改PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - oldPin: 老的PIN
    ///   - oldPin: 新的PIN
    ///   - type: 类型
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func changePin(oldPin: String, newPin: String, type: Int = 2, completion: @escaping (Result<Void, PaySDKError>) -> Void) -> DataRequest {
        let newPinToken = PinHelper.generateConfusionPinToken(with: newPin)
        let oldPinToken = PinHelper.generateConfusionPinToken(with: oldPin)

        return NetworkManager.shared
                .request(api: PaySDKAPI.changePin(oldPinToken: oldPinToken, newPinToken: newPinToken, type: type))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void, PaySDKError>) in
                    return Result.success(())
                })
    }

    /// 校验PIN
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameters:
    ///   - pin: PIN
    ///   - completion: 结果回调，返回成功或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func validatePin(pin: String, completion: @escaping (Result<Void, PaySDKError>) -> Void) -> DataRequest {
        let pinToken = PinHelper.generateConfusionPinToken(with: pin)
        return NetworkManager.shared
                .request(api: PaySDKAPI.validatePin(pinToken: pinToken))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void, PaySDKError>) in
                    return Result.success(())
                })
    }

    /// 获取汇率
    ///
    /// - Parameter completion: 汇率信息
    /// - Returns: 返回请求体
    @discardableResult
    public class func getCurrency(completion: @escaping (Result<CurrencyInfo, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.currency)
                .hanleEnvelopResponseData(completion: completion,
                        handler: { json -> (Result<CurrencyInfo, PaySDKError>) in
                            guard let currenyInfo = CurrencyInfo(jsonData: json) else {
                                return Result.failure(ErrorCode.dataError)
                            }
                            return Result.success(currenyInfo)
                        })
    }

    /// 获取公钥
    ///
    /// - Parameter completion: 公钥
    /// - Returns: 返回请求体
    @discardableResult
    class func getConfig(completion: @escaping (Result<String, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.config)
                .hanleEnvelopResponseData(completion: completion,
                        handler: { json -> (Result<String, PaySDKError>) in
                            let publicKey = json["crypto"]["publicKey"].stringValue
                            if publicKey.isEmpty {
                                return Result.failure(ErrorCode.dataError)
                            } else {
                                return Result.success(publicKey)
                            }

                        })
    }


    /// 获取用户信息
    ///
    /// - Parameter completion: 用户
    /// - Returns: 返回请求体
    @discardableResult
    public class func getUser(completion: @escaping (Result<User, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.user)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<User, PaySDKError>) in
                    guard let mappedObject = User(jsonData: json["user"]) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })

    }
    
    /// 获取钱包用户信息
    ///
    /// - Parameter completion: 钱包id
    /// - Returns: 返回请求体
    @discardableResult
    public class func getWalletUser(walletId: String, completion: @escaping (Result<User, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.walletUser(id: walletId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<User, PaySDKError>) in
                guard let mappedObject = User(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject)
            })
        
    }
    
    /// 获取地址薄
    ///
    /// - Parameter completion: 资产id
    /// - Returns: 返回请求体
    @discardableResult
    public class func getAddress(assetId: String, completion: @escaping (Result<[Address], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.getAddresses(assedId: assetId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Address], PaySDKError>) in
                guard let mappedObject = Lists<Address>(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject.items)
            })
    }
    
    @discardableResult
    public class func addAccountAddress(assetId: String, label: String, destination: String, tag: String, completion: @escaping (Result<Address, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.addAccountAddress(assedId: assetId, label: label, destination: destination, tag: tag))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Address, PaySDKError>) in
                guard let mappedObject = Address(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject)
            })
    }
    
    /// 删除地址
    ///
    /// - Parameter completion: 地址id
    /// - Returns: 返回请求体
    @discardableResult
    public class func removeAddress(addressId: String, completion: @escaping (Result<Void, PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.removeAddress(addressId: addressId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void, PaySDKError>) in
                return Result.success(())
            })
    }
    
    /// 搜索资产类型
    ///
    /// - Parameter completion: 资产类型
    /// - Returns: 返回请求体
    @discardableResult
    public class func search(symbol: String, completion: @escaping (Result<[Asset], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.searchAsset(text: symbol))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Asset], PaySDKError>) in
                guard let mappedObject = Lists<Asset>(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                
                return Result.success(mappedObject.items)
            })
    }
    
    
    /// 获取正在转入的快照
    ///
    /// - Parameter completion: 结果回调，返回正在转入的快照列表或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getPendingDeposits(assetId: String, completion: @escaping (Result<[PendingDeposit], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.pendingDeposit(asseId: assetId))
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[PendingDeposit], PaySDKError>) in
                guard let mappedObject = Lists<PendingDeposit>(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                return Result.success(mappedObject.items)
            })
    }
    
    /// 获取正在转入的所有快照
    ///
    /// - Parameter completion: 结果回调，返回正在转入的快照列表或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getAllPendingDeposits(completion: @escaping (Result<[PendingDeposit], PaySDKError>) -> Void) -> DataRequest {
        return NetworkManager.shared
            .request(api: PaySDKAPI.pendingDeposits)
            .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[PendingDeposit], PaySDKError>) in
                guard let mappedObject = Lists<PendingDeposit>(jsonData: json) else {
                    return Result.failure(ErrorCode.dataError)
                }
                return Result.success(mappedObject.items)
            })
    }
    
}

extension DataRequest {
    @discardableResult
    public func hanleEnvelopResponseData<T>(completion: @escaping ((Result<T, PaySDKError>) -> Void), handler: @escaping (JSON) -> (Result<T, PaySDKError>)) -> Self {
        return response { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)["data"]
                let statusCode = json["code"].intValue
                if statusCode == 0 {
                    completion(handler(json))
                } else {
                    completion(Result.failure(ErrorCode.dataError))
                }
                
            case .failure(let _):
                guard let data = response.data else {
                    completion(Result.failure(ErrorCode.netWorkError))
                    return
                }
                let json = JSON(data)
                let statusCode = json["code"].intValue
                
                completion(Result.failure(PaySDKError.error(code: statusCode, message: ErrorCode.errorMessage(for: statusCode) ?? json["msg"].stringValue)))
                
                
            }
        }
    }
}
