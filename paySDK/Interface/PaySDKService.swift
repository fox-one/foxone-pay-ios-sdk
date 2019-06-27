//
//  PaySDKService.swift
//  FoxOne
//
//  Created by moubuns on 2018/6/26.
//  Copyright © 2018 FoxOne. All rights reserved.
//

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
    public class func getAssets(completion: @escaping (Result<[Asset]>) -> Void) -> DataRequest {
        return NetworkManager.shared.request(api: PaySDKAPI.assets)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Asset]>) in
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
    public class func getAsset(with id: String, completion: @escaping (Result<Asset>) -> Void) -> DataRequest {
        return NetworkManager.shared.request(api: PaySDKAPI.asset(id: id))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Asset>) in
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
    public class func getSnapshot(with id: String, cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo)>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.snapshot(id: id, cursor: cursor, limit: limit))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<([Snapshot], PageInfo)>) in
                    guard let mappedObject = Lists<Snapshot>(jsonData: json, key: "snapshots") else {
                        return Result.failure(ErrorCode.dataError)
                    }
                    return Result.success((snapshots: mappedObject.items, pagination: mappedObject.pagination))
                })
    }

    @discardableResult
    public class func hideAsset(by id: String, hide: Bool, completion: @escaping (Result<Void>) -> Void) -> DataRequest {
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
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }

    /// 获取所有交易记录列表
    /// （必须在PaySDK的接口中传入PIN）
    ///
    /// - Parameter completion: 结果回调，交易记录或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getSnapshots(cursor: String, limit: Int, completion: @escaping (Result<([Snapshot], PageInfo)>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.snapshots(cursor: cursor, limit: limit))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<([Snapshot], PageInfo)>) in
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
    public class func getSnapshot(with id: String, completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.getSnapshot(id: id))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot>) in
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
    public class func getSupportAssets(completion: @escaping (Result<[Asset]>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.supportAssets)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<[Asset]>) in
                    guard let mappedObject = Lists<Asset>(jsonData: json) else {
                        return Result.failure(ErrorCode.dataError)
                    }
                    return Result.success(mappedObject.items)
                })
    }

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
    @discardableResult
    public class func withdraw(to address: String,
                               amount: String,
                               assetId: String,
                               memo: String,
                               label: String,
                               completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.withdraw(assetId: assetId, address: address, amount: amount, memo: memo, label: label))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot>) in
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
                               completion: @escaping (Result<Snapshot>) -> Void) -> DataRequest {
        let trace = traceId ?? UUID().uuidString
        return NetworkManager.shared
                .request(api: PaySDKAPI.transfer(opponentId: userId, assetId: assetId, memo: memo, amount: amount, traceId: trace.lowercased()))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Snapshot>) in
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
    ///   - address: 接收地址
    ///   - label: 标签用于EOS
    ///   - completion: 结果回调，返回手续费或者错误
    /// - Returns: 返回请求体
    @discardableResult
    public class func getFee(by id: String, address: String, label: String, completion: @escaping (Result<WithDrawFee>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.fee(assetId: id, address: address, label: label))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<WithDrawFee>) in
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
    public class func setPin(newPin: String, type: Int = 2, completion: @escaping (Result<Void>) -> Void) -> DataRequest {
        let newPinToken = PinHelper.generateConfusionPinToken(with: newPin)
        return NetworkManager.shared
                .request(api: PaySDKAPI.setPin(newPinToken: newPinToken, type: type))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void>) in
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
    public class func changePin(oldPin: String, newPin: String, type: Int = 2, completion: @escaping (Result<Void>) -> Void) -> DataRequest {
        let newPinToken = PinHelper.generateConfusionPinToken(with: newPin)
        let oldPinToken = PinHelper.generateConfusionPinToken(with: oldPin)

        return NetworkManager.shared
                .request(api: PaySDKAPI.changePin(oldPinToken: oldPinToken, newPinToken: newPinToken, type: type))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void>) in
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
    public class func validatePin(pin: String, completion: @escaping (Result<Void>) -> Void) -> DataRequest {
        let pinToken = PinHelper.generateConfusionPinToken(with: pin)
        return NetworkManager.shared
                .request(api: PaySDKAPI.validatePin(pinToken: pinToken))
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<Void>) in
                    return Result.success(())
                })
    }

    /// 获取汇率
    ///
    /// - Parameter completion: 汇率信息
    /// - Returns: 返回请求体
    @discardableResult
    public class func getCurrency(completion: @escaping (Result<CurrencyInfo>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.currency)
                .hanleEnvelopResponseData(completion: completion,
                        handler: { json -> (Result<CurrencyInfo>) in
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
    class func getConfig(completion: @escaping (Result<String>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.config)
                .hanleEnvelopResponseData(completion: completion,
                        handler: { json -> (Result<String>) in
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
    public class func getUser(completion: @escaping (Result<User>) -> Void) -> DataRequest {
        return NetworkManager.shared
                .request(api: PaySDKAPI.user)
                .hanleEnvelopResponseData(completion: completion, handler: { json -> (Result<User>) in
                    guard let mappedObject = User(jsonData: json["user"]) else {
                        return Result.failure(ErrorCode.dataError)
                    }

                    return Result.success(mappedObject)
                })

    }
}

extension DataRequest {
    @discardableResult
    public func hanleEnvelopResponseData<T>(completion: @escaping ((Result<T>) -> Void), handler: @escaping (JSON) -> (Result<T>)) -> Self {
        return responseData(queue: nil, completionHandler: { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)["data"]
                let statusCode = json["code"].intValue
                if statusCode == 0 {
                    completion(handler(json))
                } else {
                    completion(Result.failure(ErrorCode.dataError))
                }

            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}
