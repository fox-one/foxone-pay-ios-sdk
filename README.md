# Fox.ONE Pay SDK for iOS

Pay SDK 是加密货币支付解决方案的基础 SDK。基于Pay SDK 可以方便商户，开发者快速的集成数字化钱包。

* 转入
* 转出
* 资产总览
* 交易记录
* 汇率
* PIN码

## 安装    

确保你安装了最新的 [CocoaPods](https://cocoapods.org) :

在 Podfile 文件中添加:

```ruby
pod 'FoxOnePaySDK'
```

在终端执行 `pod install` 


## 在App是使用SDK

1. 在商户平台中注册用户，并且填写商户信息。在审核之后获取 AppSerect
    
2. 在您的应用中注册 SDK
     
    ```swift
    //import SDK
    import FoxOnePaySDK
    
    //Register
    PaySDK.registerSDK(key: "AppSerect", delegate: self)
    ```
3. 实现 Pay SDK Delegate

    ```swift
  extension AppDelegate: PaySDKProtcol {
        //session token 
        func f1AccessToken() -> String {
            return ""
        }
        
        func f1PublicKey() -> String {
            return ""
        }
        
        func f1PIN() -> String {
            return  ""
        }
    }
    ```
4. 调用钱包的服务
  
    ```swift  
    PaySDKService.getAssets { completion in
                switch completion {
                case .success(let assets):
                    self.handle(assets: assets)
                case .failure:
                    break
                }
            }
    ```
##  API 
    
  - [API](https://github.com/fox-one/foxone-pay-ios-sdk/blob/master/API.md) - The PaySDKService API