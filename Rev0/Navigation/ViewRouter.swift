import Foundation

final class ViewRouter: ObservableObject {
    @Published var currentPage: Page =  UserDefaults.standard.value(forKey: "logged_in")! as! Bool ? .page2 : .page3
}
