//
//  Lists.swift
//  FoxOne
//
//  Created by moubuns on 2018/6/26.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import Foundation
import SwiftyJSON

class Lists<T: PaySDKMappable> {
    let items: [T]
    let pagination: PageInfo

    required init?(jsonData: JSON, key: String = "") {
        if key.isEmpty {
            self.items = jsonData.arrayValue.compactMap {
                T(jsonData: $0)
            }
        } else {
            self.items = jsonData[key].arrayValue.compactMap {
                T(jsonData: $0)
            }
        }

        self.pagination = PageInfo(jsonData: jsonData["pagination"]) ?? PageInfo()
    }
}
