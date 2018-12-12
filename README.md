# Fox.ONE Pay SDK for iOS

Pay SDK 是加密货币支付解决方案的基础 SDK。基于Pay SDK 可以方便商户，开发者快速的集成数字化钱包。

* 转入
* 转出
* 资产总览
* 交易记录
* 汇率
* PIN码

## 集成到你的应用  

确保你安装了最新的 [CocoaPods](https://cocoapods.org) :

在 Podfile 文件中添加:

```ruby
pod 'FoxOnePaySDK'
```

在终端执行 `pod install` 

## 在 App 中使用 SDK

1. 在[商户平台](https://admin.pay.fox.one/)中注册账户，通过验证之后，并且填写商户信息提交审核。

2. 申请审核通过之后会发送 `AppSecret` 给您， `AppSecret` 是访问支付后台的令牌。
    
2. 在您的应用中注册 SDK
     
```swift
    
import FoxOnePaySDK
    
//Register
PaySDK.registerSDK(key: "AppSerect", delegate: self)
```
1. 实现 Pay SDK Delegate

```swift
extension AppDelegate: PaySDKProtcol {
    //session token 
    func f1AccessToken() -> String {
        return "" // 通过支付后端申请的Token
    }
    
    func f1PIN() -> String {
        return  "" // 用户的PIN码
    }
}
```

1. 调用钱包的服务
  
```swift  
// 获取用户钱包
PaySDKService.getAssets { completion in
            switch completion {
            case .success(let assets):
                self.handle(assets: assets)
            case .failure:
                break
            }
        }
```
##  具体 API 参考 和错误码
    
- [API](https://github.com/fox-one/foxone-pay-ios-sdk/blob/master/API.md) - The PaySDKService API