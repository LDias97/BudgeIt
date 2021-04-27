import Foundation

//final class ViewRouter: ObservableObject {
////    @Published var currentPage: Page =  (UserDefaults.standard.value(forKey: "logged_in") ?? false) as! Bool ? .page2 : .page2
//    @Published var currentPage: Page = .page3
//
//}
final class ViewRouter: ObservableObject {
    @Published var currentPage: Page =  (UserDefaults.standard.value(forKey: "logged_in") ?? false) as! Bool ? .page3 : .page1
}
