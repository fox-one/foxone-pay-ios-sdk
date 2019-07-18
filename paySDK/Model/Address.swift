//
//  Address.swift
//  Alamofire
//
//  Created by moubuns on 2019/7/18.
//

import Foundation

public struct Address: Codable {
    public let addressId: String
    public let assetId: String
    public let label: String
    public let publicKey: String
    public let accountName: String
    public let accountTag: String
    
    public enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case assetId = "asset_id"
        case label = "label"
        case publicKey = "public_key"
        case accountName = "account_name"
        case accountTag = "account_tag"
    }
    
    public init(addressId: String, assetId: String, label: String, publicKey: String, accountName: String, accountTag: String) {
        self.addressId = addressId
        self.assetId = assetId
        self.label = label
        self.publicKey = publicKey
        self.accountName = accountName
        self.accountTag = accountTag
    }
}
