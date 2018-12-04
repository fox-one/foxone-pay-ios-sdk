//
//  PaySDKError.swift
//  FoxOne
//
//  Created by moubuns on 2018/7/11.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

public enum PaySDKError: Swift.Error {
    case code(Int)
    case error(code: Int, message: String)
}

public struct ErrorCode {
    static let bundle = Bundle(for: PaySDK.self)

    let errorCode = [
        1: "INVALID_OPERATION_MSG".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        3: "SERVER_FALUT_MSG".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        1538: "user_not_found".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        1537: "user_not_logged".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        1553: "pin_not_set_message".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        1554: "incorrect_pin_message".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        1601: "invalid_public_key".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        2005: "invalid_amount".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        2006: "amount_too_small".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        -1: "address_unavaliable".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle),
        -2: "data_is_nil".localizedIn(table: "PaySDK", bundle: ErrorCode.bundle)
    ]

    internal static func errorMessage(for code: Int) -> String? {
        return ErrorCode().errorCode[code]
    }

    static var dataError = PaySDKError.error(code: -2, message: "")
}

//LocalizedString
fileprivate extension String {
    func localizedIn(table: String, bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: table, bundle: bundle, comment: "")
    }
}
