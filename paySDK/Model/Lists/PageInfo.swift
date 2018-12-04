//
//  PagInation.swift
//  FoxOne
//
//  Created by 杜一平 on 2018/9/22.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import UIKit
import SwiftyJSON

//　分页
public struct PageInfo: PaySDKMappable {
    // 游标
    public let nextCursor: String
    // 是否有下一页
    public let hasNext: Bool
    
    init?(jsonData: JSON) {
        nextCursor = jsonData["nextCursor"].stringValue
        hasNext = jsonData["hasNext"].boolValue
    }
    
    init() {
        nextCursor = ""
        hasNext = false
    }
}
