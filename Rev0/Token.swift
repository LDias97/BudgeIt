import Foundation
import Firebase
import FirebaseFunctions

class Token: ObservableObject {
    @Published var hasLoaded = false
    @Published var value: String? = nil
    @Published var vc: ViewController = ViewController()
}

extension Token {
    
    func getTokenFromCloud(completion: @escaping (String?) -> ()){
        Functions.functions().httpsCallable("createPlaidLinkToken").call { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return completion(nil)
            }
            guard let linkToken = result?.data as? String else {
                return completion(nil)
            }
            completion(linkToken)
        }
    }
    
    
    func setToken(){
        getTokenFromCloud { (linkToken) in
            guard let linkToken = linkToken , !linkToken.isEmpty else { return }
            DispatchQueue.main.async {
                self.value = linkToken
                self.vc.setToken(token: self.value!)
                self.hasLoaded = true
            }
        }
    }
    
    
}
