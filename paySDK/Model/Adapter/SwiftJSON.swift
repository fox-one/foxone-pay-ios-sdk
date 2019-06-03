//
//  SwiftJSON.swift
//  FoxOne
//
//  Created by moubuns on 2018/8/30.
//  Copyright © 2018 FoxOne. All rights reserved.
//

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
        price = jsonData["price"].doubleValue
        changeBTCPercentage = jsonData["change_btc"].doubleValue
        changeUSDPercentage = jsonData["change_usd"].doubleValue
        priceBTC = jsonData["price_btc"].doubleValue
        priceUSD = jsonData["price_usd"].doubleValue
        changeCNYPercentage = jsonData["change"].doubleValue

    }
}

extension Snapshot: PaySDKMappable {

    public init?(jsonData: JSON) {
        amount = jsonData["amount"].doubleValue
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
        amount = jsonData["amount"].doubleValue
        assetId = jsonData["asset_id"].stringValue
        assetSymbol = jsonData["asset_symbol"].stringValue
    }
}

extension WithDrawFee: PaySDKMappable {
    init?(jsonData: JSON) {
        feeAsset = Asset(jsonData: jsonData["fee_asset"])
        feeAmount = jsonData["fee_amount"].doubleValue
        fee = Fee(jsonData: jsonData["fee"])
    }
}

extension Asset: PaySDKMappable {
    init?(jsonData: JSON) {
        assetId = jsonData["asset_id"].stringValue
        balance = jsonData["balance"].doubleValue
        chainId = jsonData["chain_id"].stringValue
        changeBTCPercentage = jsonData["change_btc"].doubleValue
        changeUSDPercentage = jsonData["change_usd"].doubleValue
        changeCNYPercentage = jsonData["change"].doubleValue
        icon = jsonData["icon"].stringValue
        name = jsonData["name"].stringValue
        price = jsonData["price"].doubleValue
        priceBTC = jsonData["price_btc"].doubleValue
        priceUSD = jsonData["price_usd"].doubleValue
        publicKey = jsonData["public_key"].stringValue
        symbol = jsonData["symbol"].stringValue
        accountName = jsonData["account_name"].stringValue
        accountTag = jsonData["account_tag"].stringValue
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
