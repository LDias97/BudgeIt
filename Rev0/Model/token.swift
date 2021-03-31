import Foundation
import Firebase

final class LToken: ObservableObject {
    @Published var token: String = ""
    
    func setToken(token: String){
        self.token = token;
    }
    
    init() {
        Functions.functions().httpsCallable("createPlaidLinkToken").call { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            guard let linkToken = result?.data as? String else {
                return
            }
            self.setToken(token: linkToken)
        }
    }
}

