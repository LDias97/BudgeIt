import Foundation

final class ViewRouter: ObservableObject {
    @Published var currentPage: Page =  UserDefaults.standard.value(forKey: "logged_in")! as! Bool ? .page3 : .page2
}
