import Foundation
import Alamofire

enum PaySDKAPI {
    case config
    case assets
    case asset(id: String)
    case snapshots(cursor: String, limit: Int)
    case snapshot(id: String, cursor: String, limit: Int)
    case getSnapshot(id: String)
    
    case fee(assetId: String, destination: String, tag: String)
    case supportAssets
    
    case setPin(newPinToken: String, type: Int)
    case changePin(oldPinToken: String, newPinToken: String, type: Int)
    case validatePin(pinToken: String)
    
    case hideAsset(id: String)
    case showAsset(id: String)
    case currency
    
    case transfer(opponentId: String, assetId: String, memo: String, amount: String, traceId: String)
    case user
    case walletUser(id: String)
    case getAddresses(assedId: String)
    case addAccountAddress(assedId: String, label: String, destination: String, tag: String)
    case removeAddress(addressId: String)
    
    case withdrawToDestination(assetId: String, amount: String, destination: String, tag: String, memo: String)
    case withdrawToAddressId(assetId: String, amount: String, addressId: String)
    case withdrawToWalletId(assetId: String, amount: String, walletId: String)
    case searchAsset(text: String)
    case pendingDeposits
    case pendingDeposit(asseId: String)
    case pendingChainDeposit(chainId: String)
    
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
        case .withdrawToDestination:
            return "/wallet/withdraw"
        case .withdrawToAddressId:
            return "/wallet/withdraw"
        case .withdrawToWalletId:
            return "/wallet/transfer"
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
        case .walletUser(let id):
            return "/wallet/user/\(id)"
        case .getAddresses:
            return "/wallet/addresses"
        case .addAccountAddress:
            return "/wallet/address"
        case .removeAddress(let id):
            return "/wallet/address/\(id)"
        case .searchAsset:
            return "/wallet/search-assets"
        case .pendingDeposit:
            return "/wallet/pending-deposits"
        case .pendingChainDeposit:
            return "/wallet/pending-deposits"
        case .pendingDeposits:
            return "/wallet/pending-deposits"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .withdrawToDestination, .withdrawToAddressId, .withdrawToWalletId, .hideAsset, .transfer, .validatePin, .showAsset, .addAccountAddress:
            return .post
        case .setPin, .changePin:
            return .put
        case .removeAddress:
            return .delete
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
        case .transfer(let opponentId, let assetId, let memo, let amount, let traceId):
            return ["opponent_id": opponentId, "asset_id": assetId, "memo": memo, "amount": amount ,"trace_id": traceId]
        case .getAddresses(let assedId):
            return ["asset_id": assedId]
        case .addAccountAddress(let assedId ,let label, let destination, let tag):
            return ["asset_id": assedId, "label": label, "destination": destination, "tag": tag]
        case .withdrawToDestination(let assetId, let amount, let destination, let tag, let memo):
            return ["destination": destination, "tag": tag, "amount": amount, "asset_id": assetId, "memo": memo,"trace_id": UUID().uuidString.lowercased()]
        case .withdrawToAddressId(let assetId,let  amount,let  addressId):
            return ["address_id": addressId, "amount": amount, "asset_id": assetId, "trace_id": UUID().uuidString.lowercased()]
        case .withdrawToWalletId(let assetId, let amount,let  walletId):
            return ["opponent_id": walletId, "asset_id": assetId, "amount": amount ,"trace_id": UUID().uuidString.lowercased()]
        case .searchAsset(let text):
            return ["symbol": text, "mode": "fuzzy"]
        case .pendingDeposit(let assetId):
            return ["asset_id": assetId]
        case .pendingChainDeposit(let chainId):
            return ["chain_id": chainId]
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

    var headers: HTTPHeaders? {
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
