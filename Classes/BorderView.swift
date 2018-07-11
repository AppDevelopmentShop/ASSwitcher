//
//  BorderView.swift
//  ASSwitcher
//
//  Created by Maksym on 7/11/18.
//

import UIKit

class BorderView: UIView {
    
    private var _borderWidth: CGFloat = 0;
    @IBInspectable var borderWidth: CGFloat {
        set {
            self._borderWidth = newValue;
            self.layer.borderWidth = newValue;
        }
        get {
            return self._borderWidth;
        }
    }
    
    private var _borderColor: CGColor = UIColor.clear.cgColor;
    @IBInspectable var borderColor: CGColor {
        set {
            self._borderColor = newValue;
            self.layer.borderColor = newValue;
        }
        get {
            return _borderColor;
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = rect.height / 2
        self.borderColor = self._borderColor;
        self.borderWidth = self._borderWidth;
    }
}
