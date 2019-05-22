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
        assetId = jsonData["assetId"].stringValue
        name = jsonData["name"].stringValue
        symbol = jsonData["symbol"].stringValue
        icon = jsonData["icon"].stringValue
        chainId = jsonData["chainId"].stringValue
        
        price = jsonData["price"].doubleValue
        changeBTCPercentage = jsonData["changeBtc"].doubleValue
        changeUSDPercentage = jsonData["changeUsd"].doubleValue
        priceBTC = jsonData["priceBtc"].doubleValue
        priceUSD = jsonData["priceUsd"].doubleValue
        changeRMBPercentage = jsonData["changeUsd"].doubleValue
        
    }
}

extension Snapshot: PaySDKMappable {
    
    public init?(jsonData: JSON) {
        amount = jsonData["amount"].doubleValue
        assetId = jsonData["assetId"].stringValue
        createdAt = jsonData["createdAt"].doubleValue
        memo = jsonData["memo"].stringValue
        snapshotId = jsonData["snapshotId"].stringValue
        traceId = jsonData["traceId"].stringValue
        transactionHash = jsonData["transactionHash"].stringValue
        opponentId = jsonData["opponentId"].stringValue
        receiver = jsonData["receiver"].stringValue
        sender = jsonData["sender"].stringValue
        source = jsonData["source"].stringValue
        userId = jsonData["userId"].stringValue

        opponent = Opponent(jsonData: jsonData["opponent"])
        asset = Asset(jsonData: jsonData["asset"])
    }
}

extension Fee: PaySDKMappable {
    init?(jsonData: JSON) {
        amount = jsonData["amount"].doubleValue
        assetId = jsonData["assetId"].stringValue
        assetSymbol = jsonData["assetSymbol"].stringValue
    }
}

extension WithDrawFee: PaySDKMappable {
    init?(jsonData: JSON) {
        feeAsset = Asset(jsonData: jsonData["feeAsset"])
        feeAmount = jsonData["feeAmount"].doubleValue
        fee = Fee(jsonData: jsonData["fee"])
    }
}

extension Asset: PaySDKMappable {
    init?(jsonData: JSON) {
        assetId = jsonData["assetId"].stringValue
        balance = jsonData["balance"].doubleValue
        chainId = jsonData["chainId"].stringValue
        changeBTCPercentage = jsonData["changeBtc"].doubleValue
        changeUSDPercentage = jsonData["changeUsd"].doubleValue
        changeRMBPercentage = jsonData["changeUsd"].doubleValue
        icon = jsonData["icon"].stringValue
        name = jsonData["name"].stringValue
        price = jsonData["price"].doubleValue
        priceBTC = jsonData["priceBtc"].doubleValue
        priceUSD = jsonData["priceUsd"].doubleValue
        publicKey = jsonData["publicKey"].stringValue
        symbol = jsonData["symbol"].stringValue
        accountName = jsonData["accountName"].stringValue
        accountTag = jsonData["accountTag"].stringValue
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
        foxId = jsonData["foxId"].intValue
        mixinId = jsonData["mixinId"].stringValue
        avatar = jsonData["avatar"].stringValue
        fullname = jsonData["fullname"].stringValue
    }
}

extension CNYTicker: PaySDKMappable {
    init?(jsonData: JSON) {
        changeIn24h = jsonData["changeIn24h"].stringValue
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
        cnyTickers = jsonData["cnyTickers"].arrayValue.compactMap { CNYTicker(jsonData: $0) }
    }
}

extension User: PaySDKMappable {
    init?(jsonData: JSON) {
        id = jsonData["userId"].stringValue
        avatar = jsonData["avatar"].stringValue
        email = jsonData["email"].stringValue
        name = jsonData["fullname"].stringValue
        isActive = jsonData["isActive"].boolValue
        isPinSet = jsonData["isPinSet"].boolValue
        pinType = jsonData["pinType"].intValue
    }
}
