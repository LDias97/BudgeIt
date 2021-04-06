import LinkKit
import SwiftUI
import Foundation

struct LinkController {
    enum LinkConfigurationType {
        case publicKey(LinkPublicKeyConfiguration)
        case linkToken(LinkTokenConfiguration)
    }
    
    let configuration: LinkConfigurationType
    let openOptions: OpenOptions
    let onCreateError: ((Plaid.CreateError) -> Void)?
    
    init(
        configuration: LinkConfigurationType,
        openOptions: OpenOptions = [:],
        onCreateError: ((Plaid.CreateError) -> Void)? = nil
    ) {
        self.configuration = configuration
        self.openOptions = openOptions
        self.onCreateError = onCreateError
    }
}

extension LinkController: UIViewControllerRepresentable {
    
    class Coordinator: NSObject {
        var parent: LinkController
        var handler: Handler?
        
        init(_ parent: LinkController) {
            self.parent = parent
        }
        
        func createHandler() -> Result<Handler, Plaid.CreateError> {
            switch parent.configuration {
            case .publicKey(let configuration):
                return Plaid.create(configuration)
            case .linkToken(let configuration):
                return Plaid.create(configuration)
            }
        }
        
        func present(_ handler: Handler, in viewController: UIViewController) -> Void {
            guard self.handler == nil else {
                return
            }
            self.handler = handler

            handler.open(presentUsing: .custom({ linkViewController in
                viewController.addChild(linkViewController)
                viewController.view.addSubview(linkViewController.view)
                linkViewController.view.translatesAutoresizingMaskIntoConstraints = false
                linkViewController.view.frame = viewController.view.bounds
                NSLayoutConstraint.activate([
                    linkViewController.view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                    linkViewController.view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
                    linkViewController.view.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
                    linkViewController.view.heightAnchor.constraint(equalTo: viewController.view.heightAnchor),
                ])
                linkViewController.didMove(toParent: viewController)
            }), parent.openOptions)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        
        let handler = context.coordinator.createHandler()
        let present: (Handler) -> Handler = { handler in
            context.coordinator.present(handler, in: viewController)
            return handler
        }
        let handleError: (Plaid.CreateError) -> Plaid.CreateError = { error in
            onCreateError?(error)
            return error
        }
        
        _ = handler.map(present)
        _ = handler.mapError(handleError)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
