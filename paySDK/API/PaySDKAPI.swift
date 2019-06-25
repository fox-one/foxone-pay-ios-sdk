//
//  PaySDKAPI.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/31.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation
import Alamofire

enum PaySDKAPI {
    case config
    case assets
    case asset(id: String)
    case snapshots(cursor: String, limit: Int)
    case snapshot(id: String, cursor: String, limit: Int)
    case getSnapshot(id: String)
    case withdraw(assetId: String, address: String, amount: String, memo: String, label: String)
    case fee(assetId: String, address: String, label: String)
    case supportAssets
    case setPin(newPinToken: String, type: Int)
    case changePin(oldPinToken: String, newPinToken: String, type: Int)
    case validatePin(pinToken: String)
    case hideAsset(id: String)
    case showAsset(id: String)
    case currency
    case transfer(opponentId: String, assetId: String, memo: String, amount: String)
    case user

    var path: String {
        switch self {
        case .config:
            return "/config"
        case .assets:
            return "/wallet/assets"
        case .asset(let assetId):
            return "/wallet/asset/\(assetId)"
        case .snapshots:
            return "/wallet/snapshots"
        case .getSnapshot(let snapshotId):
            return "/wallet/snapshot/\(snapshotId)"
        case .snapshot:
            return "/wallet/snapshots"
        case .withdraw:
            return "/wallet/withdraw"
        case .fee:
            return "/wallet/withdraw/fee"
        case .supportAssets:
            return "/wallet/assets"
        case .changePin:
            return "/account/pin"
        case .setPin:
            return "/account/pin"
        case .validatePin:
            return "/account/pin-verify"
        case .hideAsset:
            return "/wallet/asset/option"
        case .showAsset:
            return "/wallet/asset/option"
        case .currency:
            return "/trade-data/currency"
        case .transfer:
            return "/wallet/transfer"
        case .user:
            return "/account/detail"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .withdraw, .hideAsset, .transfer, .validatePin, .showAsset:
            return .post
        case .setPin, .changePin:
            return .put
        default:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .snapshots(let cursor, let limit):
            return ["cursor": cursor, "limit": limit]
        case .snapshot(let id, let cursor, let limit):
            return ["asset_id": id, "cursor": cursor, "limit": limit]
        case .withdraw(let assetId, let address, let amount, let memo, let label):
            var param: [String: Any] = [:]
            if !label.isEmpty {
                param = ["account_name": address, "account_tag":label, "amount": amount, "asset_id": assetId, "memo": memo,"trace_id": UUID().uuidString]
            } else {
                param = ["public_key": address, "amount": amount, "asset_id": assetId, "memo": memo,"trace_id": UUID().uuidString]
            }
            
            return param
        case .fee(let id, let address, let label):
            var param: [String: Any] = ["asset_id": id, "public_key": address, "label": label]
            if !label.isEmpty {
                param["label"] = label
            }
            return param
        case .supportAssets:
            return ["entirechain": "1"]
        case .setPin(let newPinToken, let type):
            return ["pin_type": type, "new_pin_token": newPinToken]
        case .changePin(_, let newPinToken, let type):
            return ["pin_type": type, "new_pin_token": newPinToken]
        case .transfer(let opponentId, let assetId, let memo, let amount):
            return ["opponent_id": opponentId, "asset_id": assetId, "memo": memo, "amount": amount ,"trace_id": UUID().uuidString.lowercased()]
        default:
            return nil
        }
    }

    var body: Any? {
        switch self {
        case .showAsset(let id):
            return [["asset_id": id, "hide": false]]
        case .hideAsset(let id):
            return [["asset_id": id, "hide": true]]
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var headers: [String: String]? {
        switch self {
        case .changePin(let pinToken, _, _):
            return [foxCustomPinHeader: pinToken]
        case .validatePin(let pinToken):
            return [foxCustomPinHeader: pinToken]
        case .config:
            return [foxCustomKeyHeader: PaySDK.shared.appKey ?? ""]
        default:
            guard let pin = PaySDK.shared.delegate?.f1PIN(), !pin.isEmpty else {
                return nil
            }
            return [foxCustomPinHeader: PinHelper.generateConfusionPinToken(with: pin)]
        }
    }

    var url: String {
        return PaySDK.shared.baseURL + self.path
    }
}
