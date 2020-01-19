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
