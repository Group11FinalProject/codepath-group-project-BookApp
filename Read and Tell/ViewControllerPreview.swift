//
//  ViewControllerPreview.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/6/22.
//

import SwiftUI

@available(iOS 13.0, *)

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    public var previews: some View {
        return Preview(viewController: self)
    }
}
