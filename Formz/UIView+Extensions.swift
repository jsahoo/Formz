//
//  UIView+Extensions.swift
//  Formz
//
//  Created by Jonathan Sahoo on 6/1/18.
//  Copyright © 2018 Jonathan Sahoo. All rights reserved.
//

import Foundation

extension UIView {
    func loadViewFromNib(_ name: String) {
        let bundle = Bundle(for: type(of: self))
        guard let view = UINib(nibName: name, bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load view from nib \"\(name)\"")
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
