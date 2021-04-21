import Foundation

final class ViewRouter: ObservableObject {
    @Published var currentPage: Page =  (UserDefaults.standard.value(forKey: "logged_in") ?? false) as! Bool ? .page1 : .page1

}
