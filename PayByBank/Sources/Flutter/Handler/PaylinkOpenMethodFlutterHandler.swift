import Flutter

class PaylinkOpenMethodFlutterHandler: PaylinkFlutterMethodHandler {
    
    func handle(methodCall: FlutterMethodCall, sink: @escaping FlutterEventSink) {
        guard let arguments = methodCall.arguments as? [String: Any],
              let uid = arguments["uid"] as? String else { return }
        self.open(uid: uid, sink: sink)
    }
}

// MARK: - Open
extension PaylinkOpenMethodFlutterHandler {
    
    public func open(uid: String, sink: @escaping FlutterEventSink) {
        guard let rootViewController = PaylinkFlutterModule.rootViewController else { return }
        
        Paylink.shared.open(paylinkID: uid, viewController: rootViewController) { result in
            switch result {
            case .success(let model):
                sink(model)
            case .failure(let error):
                sink(error)
            }
        }
    }
}
