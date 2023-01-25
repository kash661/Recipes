//
//  UIViewController+extension.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissOnMainQueue() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
