import Flutter

class PaylinkOpenMethodFlutterHandler: PaylinkFlutterMethodHandler {
    
    func handle(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = methodCall.arguments as? [String: Any],
              let uid = arguments["uid"] as? String else { return }
        self.open(uid: uid, flutterResult: result)
    }
}

// MARK: - Open
extension PaylinkOpenMethodFlutterHandler {
    
    public func open(uid: String, flutterResult: @escaping FlutterResult) {
        guard let rootViewController = PaylinkFlutterModule.rootViewController else { return }
        
        Paylink.shared.open(paylinkID: uid, viewController: rootViewController) { result in
            switch result {
            case .success(let model):
                flutterResult(model)
            case .failure(let error):
                flutterResult(error)
            }
        }
    }
}
