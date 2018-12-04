//
//  PinHelper.swift
//  FoxOne
//
//  Created by moubuns on 2018/9/5.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation

public class PinHelper {
    /// 生成PIN未混淆的PinToken
    ///
    /// - Parameter pin: PIN
    /// - Returns: PinToken
    public static func generatePinToken(with pin: String) -> String {
        return SecureData(key: pin).jsonString?.rsaToken ?? ""
    }
}
