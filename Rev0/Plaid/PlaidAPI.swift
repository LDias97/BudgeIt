import Foundation
import FirebaseFunctions

class PlaidAPI {
    
    class func createLinkToken(completion: @escaping (String?) -> ()){
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
    
}
