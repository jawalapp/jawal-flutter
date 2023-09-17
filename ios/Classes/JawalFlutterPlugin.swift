import Flutter
import UIKit
import JawalSwift

public class JawalFlutterPlugin: NSObject, FlutterPlugin {

    static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _channel = FlutterMethodChannel(name: "jawal_flutter", binaryMessenger: registrar.messenger())
        let instance = JawalFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: _channel)
        JawalFlutterPlugin.channel = _channel
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      switch(call.method){
          
        case "init":
          self.callInit(call, result)
          break
      case "startTracking":
        self.callStartTracking(call, result)
          break
      case "stopTracking":
        self.callStopTracking(call, result)
          break
      case "isTracking":
        self.callIsTracking(call, result)
          break
      default:
          print("Unexpected call method")
      }
  }
    
  func callInit(_ call: FlutterMethodCall, _ result: @escaping FlutterResult){
        if let args = call.arguments as? [String: Any] {
            guard let sdkKey = args["sdkKey"] as? String else {
                print("No sdkKey provided")
                return
            }
            guard let userId = args["userId"] as? String else {
                print("No userID provided")
                return
            }
            let userDescription = args["userDescription"] as? String ?? ""
            
            Jawal.start { conf in
                conf.sdk_key = sdkKey
                conf.user_id = userId
                conf.description = userDescription
                conf.enable_background_tracking = true //TODO: change
            }completion: { initResult in
                //TODO: send to dart
                
                let response = InitResult(error: "", isSuccessful: initResult, User: nil)
                
                if let channel = JawalFlutterPlugin.channel {
                    let encoder = JSONEncoder()
                    if let json = try? encoder.encode(response) {
                        channel.invokeMethod("onInitResult", arguments: String(data:json, encoding: .utf8))
                    }
                }
                print("result \(initResult)")
            }
        } else {
            print("Invalid arguments")
        }
        result(nil)
    }
    
    func callStartTracking(_ call: FlutterMethodCall, _ result: @escaping FlutterResult){
        if let jawal = Jawal.instance {
            jawal.startTracking()
        }
        result(nil)
    }
    
    func callStopTracking(_ call: FlutterMethodCall, _ result: @escaping FlutterResult){
        if let jawal = Jawal.instance {
            jawal.stopTracking()
        }
        result(nil)
    }
    
    func callIsTracking(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let jawal = Jawal.instance {
            result(jawal.isTracking())
        }else{
            result(false)
        }
        
    }
}

struct InitResult:Codable {
    let error: String
    let isSuccessful: Bool
    let User: String?
}
