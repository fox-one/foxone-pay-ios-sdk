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
//    public let publicKey: String //D
//    public let accountName: String //D
//    public let accountTag: String //D
    public let destination: String
    public let tag: String
    
    public enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case assetId = "asset_id"
        case label = "label"
//        case publicKey = "public_key"
//        case accountName = "account_name"
//        case accountTag = "account_tag"
        case destination = "destination"
        case tag = "tag"
        
    }
    
    public init(addressId: String, assetId: String, label: String, destination: String, tag: String) {
        self.addressId = addressId
        self.assetId = assetId
        self.label = label
        self.destination = destination
        self.tag = tag
//        self.publicKey = publicKey
//        self.accountName = accountName
//        self.accountTag = accountTag
    }
}
