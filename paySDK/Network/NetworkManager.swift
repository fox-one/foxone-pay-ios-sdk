import Foundation
import Alamofire
import SwiftyJSON

final class NetworkManager {
    static let shared = NetworkManager()
    private let sessionManager = Session(interceptor: RequestAuthAdapter())

    init() {
    }

    func request(api: PaySDKAPI) -> DataRequest {
        var originalRequest: URLRequest?
        let options = JSONSerialization.WritingOptions()

        do {
            originalRequest = try URLRequest(url: api.url, method: api.method, headers: api.headers)
            var encodedURLRequest = try api.parameterEncoding.encode(originalRequest!, with: api.parameters)
            if let body = api.body {
                let data = try JSONSerialization.data(withJSONObject: body, options: options)

                if encodedURLRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    encodedURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }

                encodedURLRequest.httpBody = data
            }

            return sessionManager
                    .request(encodedURLRequest)
                    .validate({ _, response, data -> Request.ValidationResult in
                        var acceptableStatusCodes: [Int] {
                            return Array(200..<300)
                        }

                        if acceptableStatusCodes.contains(response.statusCode) {
                            return .success(())
                        } else {
                            guard let data = data else {
                                return .failure(ErrorCode.dataError)
                            }

                            let json = JSON(data)
                            let statusCode = json["code"].intValue
                            return .failure(PaySDKError.error(code: statusCode, message: ErrorCode.errorMessage(for: statusCode) ?? json["msg"].stringValue))
                        }
                    })

        } catch {
            return self.request(api: api)
        }

    }

}
