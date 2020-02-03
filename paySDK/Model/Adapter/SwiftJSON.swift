import Foundation
import SwiftyJSON

internal protocol PaySDKMappable {
    init?(jsonData: JSON)
}

extension WalletAsset: PaySDKMappable {
    init?(jsonData: JSON) {
        assetId = jsonData["asset_id"].stringValue
        name = jsonData["name"].stringValue
        symbol = jsonData["symbol"].stringValue
        icon = jsonData["icon"].stringValue
        chainId = jsonData["chain_id"].stringValue
        price = jsonData["price"].stringValue
        changeBTCPercentage = jsonData["change_btc"].stringValue
        changeUSDPercentage = jsonData["change_usd"].stringValue
        priceBTC = jsonData["price_btc"].stringValue
        priceUSD = jsonData["price_usd"].stringValue
        changeCNYPercentage = jsonData["change"].stringValue
        confirmations = jsonData["confirmations"].intValue

    }
}

extension Snapshot: PaySDKMappable {
    public init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return nil
        }
        
        amount = jsonData["amount"].stringValue
        assetId = jsonData["asset_id"].stringValue
        createAt = jsonData["create_at"].doubleValue
        memo = jsonData["memo"].stringValue
        snapshotId = jsonData["snapshot_id"].stringValue
        traceId = jsonData["trace_id"].stringValue
        transactionHash = jsonData["transaction_hash"].stringValue
        opponentId = jsonData["opponent_id"].stringValue
        receiver = jsonData["receiver"].stringValue
        sender = jsonData["sender"].stringValue
        source = jsonData["source"].stringValue
        userId = jsonData["user_id"].stringValue

        opponent = Opponent(jsonData: jsonData["opponent"])
        asset = Asset(jsonData: jsonData["asset"])
    }
}

extension Fee: PaySDKMappable {
    init?(jsonData: JSON) {
        amount = jsonData["amount"].stringValue
        assetId = jsonData["asset_id"].stringValue
        assetSymbol = jsonData["asset_symbol"].stringValue
    }
}

extension WithDrawFee: PaySDKMappable {
    init?(jsonData: JSON) {
        feeAsset = Asset(jsonData: jsonData["fee_asset"])
        feeAmount = jsonData["fee_amount"].stringValue
        fee = Fee(jsonData: jsonData["fee"])
    }
}

extension Asset: PaySDKMappable {
    init?(jsonData: JSON) {
        assetId = jsonData["asset_id"].stringValue
        balance = jsonData["balance"].stringValue
        chainId = jsonData["chain_id"].stringValue
        changeBTCPercentage = jsonData["change_btc"].stringValue
        changeUSDPercentage = jsonData["change_usd"].stringValue
        changeCNYPercentage = jsonData["change"].stringValue
        icon = jsonData["icon"].stringValue
        name = jsonData["name"].stringValue
        price = jsonData["price"].stringValue
        priceBTC = jsonData["price_btc"].stringValue
        priceUSD = jsonData["price_usd"].stringValue
        destination = jsonData["destination"].stringValue
        symbol = jsonData["symbol"].stringValue
        tag = jsonData["tag"].stringValue
        chain = WalletAsset(jsonData: jsonData["chain"])
        option = Option(jsonData: jsonData["option"]) ?? Option(hide: false)
    }
}

extension Option: PaySDKMappable {
    init?(jsonData: JSON) {
        hide = jsonData["hide"].boolValue
    }
}


extension Opponent: PaySDKMappable {
    init?(jsonData: JSON) {
        foxId = jsonData["fox_id"].intValue
        mixinId = jsonData["mixin_id"].stringValue
        avatar = jsonData["avatar"].stringValue
        fullname = jsonData["fullname"].stringValue
    }
}

extension CNYTicker: PaySDKMappable {
    init?(jsonData: JSON) {
        changeIn24h = jsonData["change_in_24h"].stringValue
        from = jsonData["from"].stringValue
        price = jsonData["price"].stringValue
        timestamp = jsonData["timestamp"].doubleValue
        to = jsonData["to"].stringValue
    }
}

extension Currency: PaySDKMappable {
    init?(jsonData: JSON) {
        bitcny = jsonData["bitcny"].stringValue
        usdt = jsonData["usdt"].stringValue
    }
}

extension CurrencyInfo: PaySDKMappable {
    init?(jsonData: JSON) {
        currency = Currency(jsonData: jsonData["currencies"])
        cnyTickers = jsonData["cny_tickers"].arrayValue.compactMap {
            CNYTicker(jsonData: $0)
        }
    }
}

extension User: PaySDKMappable {
    init?(jsonData: JSON) {
        id = jsonData["user_id"].stringValue
        avatar = jsonData["avatar"].stringValue
        email = jsonData["email"].stringValue
        name = jsonData["fullname"].stringValue
        isActive = jsonData["is_active"].boolValue
        isPinSet = jsonData["is_pinset"].boolValue
        pinType = jsonData["pin_type"].intValue
    }
}

extension Address: PaySDKMappable {
    init?(jsonData: JSON) {
        self.addressId = jsonData["address_id"].stringValue
        self.assetId = jsonData["asset_id"].stringValue
        self.label = jsonData["label"].stringValue
        self.destination = jsonData["destination"].stringValue
        self.tag = jsonData["tag"].stringValue
//        self.publicKey = jsonData["public_key"].stringValue
//        self.accountName = jsonData["account_name"].stringValue
//        self.accountTag = jsonData["account_tag"].stringValue
    }
}

extension PendingDeposit: PaySDKMappable {
    init?(jsonData: JSON) {
        if jsonData.isEmpty {
            return nil
        }
        self.amount = jsonData["amount"].stringValue
        self.assetId =  jsonData["asset_id"].stringValue
        self.chainId = jsonData["chain_id"].stringValue
        self.confirmations = jsonData["confirmations"].intValue
        self.createdAt = jsonData["created_at"].doubleValue
        self.publicKey = jsonData["public_key"].stringValue
        self.threshold = jsonData["threshold"].intValue
        self.transactionHash = jsonData["transaction_hash"].stringValue
        self.transactionId = jsonData["transaction_id"].stringValue
        self.type = jsonData["type"].stringValue
    }
}
