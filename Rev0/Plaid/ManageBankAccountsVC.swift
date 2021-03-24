//import UIKit
//import LinkKit
//import FirebaseFunctions
//
//class ManageBankAccountsVC: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//    var banks = [Bank]()
//    var linkHandler: Handler?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        banks = Wallet.instance.bankAccounts
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
//    }
//
//    @IBAction func addBankAccountClicked(_ sender: Any) {
//        presentPlaidLinkUsingLinkToken()
//    }
//}
//
//extension ManageBankAccountsVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return banks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let bank = banks[indexPath.row]
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "BankCell")
//        cell.textLabel?.text = bank.bankName
//        cell.detailTextLabel?.text = "Ending In: \(bank.lastFour)"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
//            self.presentAlertToDelete(index: indexPath.row)
//        }
//
//        let swipaActions = UISwipeActionsConfiguration(actions: [contextItem])
//
//        return swipaActions
//    }
//
//    func presentAlertToDelete(index: Int) {
//
//        let alert = UIAlertController(title: "Delete Payment Method", message: "Are you sure you want to delete this payment method?", preferredStyle: .alert)
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let delete = UIAlertAction(title: "Yes", style: .default) { [self] (action) in
//            self.confirmBankDelete(index: index)
//        }
//
//        alert.addAction(cancel)
//        alert.addAction(delete)
//        present(alert, animated: true, completion: nil)
//    }
//
//    func confirmBankDelete(index: Int) {
//
//        guard let stripeId = UserManager.instance.user?.stripeId else { return }
//
//        let bank = banks[index]
//        banks.remove(at: index)
//        Wallet.instance.bankAccounts.remove(at: index)
//        tableView.reloadData()
//
//        let json: [String: Any] = [
//            "customer_id": stripeId,
//            "source": bank.id
//        ]
//
//        Functions.functions().httpsCallable("deleteSource").call(json) { (result, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//                return
//            }
//        }
//    }
//}
