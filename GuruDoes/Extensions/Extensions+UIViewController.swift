//
//  Extensions+UIViewController.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit


protocol Navigatable {
    /// Storyboard name where this view controller exists.
    static var storyboardName: String { get }
    
    /// Storyboard Id of this view controller.
    static var storyboardId: String { get }
    
    /// Returns a new instance created from Storyboard identifiers.
    static func instantiateFromStoryboard() -> Self
}


/**
 Extension of Navigatable protocol with default implementations.
 */
extension Navigatable {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.storyboardId) as? Self else {
            fatalError("Cannot instantiate the controller.")
        }
        
        return viewController
    }
}

extension UIViewController {
    

    /// Pushes a view controller of the provided type.
    ///
    /// - Parameters:
    ///   - viewControllerType: Type of view controller to push.
    ///   - completion: Function to be executed on completion.
    ///                 Contains the view controller that was pushed when successful and nil otherwise.
    func pushViewControllerOfType<T: Navigatable>(viewControllerType: T.Type, completion: (T) -> Void) {
        let viewController = T.instantiateFromStoryboard()
        guard let vc = viewController as? UIViewController else {
            fatalError("pushViewControllerOfType throw error")
        }
        
        push(vc, animated: true)
        completion(viewController)
    }
    
    /// Pushes a view controller at current navigation view controller.
    ///
    /// - Parameters:
    ///   - viewController: pushes view controller
    ///   - animated: animation value (default - true)
    func push(_ viewController: UIViewController, animated: Bool = true) {
        guard let navVC = self.navigationController else {
            fatalError("pushViewController throw error")
        }
        
        navVC.pushViewController(viewController, animated: true)
    }
    
    /// Pops the top view controller from the navigation stack and updates the display.
    ///
    /// - Parameter animated: boolean value indicated whether navigationController should be animated
    internal func popVC(animated: Bool = false) {
        
        guard let navigationController = navigationController else {
           fatalError("navigationController throw error")
        }
        navigationController.popViewController(animated: animated)
    }

}


extension UIViewController {
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    /// Func to present UIAlertController.
    ///
    /// - Parameters:
    ///   - title: Alert title.
    ///   - message: Alert message.
    ///   - alertActionTitle: Title for alert action.
    func showAlert(title: String, message: String, alertActionTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertActionTitle, style: .default) { [weak self] (done) in
            self?.popVC(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
