import UIKit
import SwiftyJSON

//　分页
public struct PageInfo: PaySDKMappable {
    // 游标
    public let nextCursor: String
    // 是否有下一页
    public let hasNext: Bool

    init?(jsonData: JSON) {
        nextCursor = jsonData["next_cursor"].stringValue
        hasNext = jsonData["has_next"].boolValue
    }

    init() {
        nextCursor = ""
        hasNext = false
    }
}
