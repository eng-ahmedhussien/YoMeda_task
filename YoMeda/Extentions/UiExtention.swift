//
//  UiExtention.swift
//  YoMeda
//
//  Created by Ahmed Hussien on 21/10/2022.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}
@IBDesignable
class DesignableButton: UIButton {
}
@IBDesignable
class DesignableLabel: UILabel {
}
@IBDesignable
class DesignableTextField: UITextField {
}
@IBDesignable
class DesignableTUITextView: UITextView {
}
@IBDesignable
class DesignableTableView: UITableView {
}
@IBDesignable
class DesignableTableViewCell: UITableViewCell {
}
@IBDesignable
class DesignableCollectionView: UICollectionView {
}
@IBDesignable
class DesignableCollectionViewCell: UICollectionViewCell {
}
@IBDesignable
class DesignableUIImageView: UIImageView{
}
//MARK: Solutions To Common Problems Shadows And Rounded Corners At The Same Time
//@IBInspectable override var clipsToBounds : Bool {
//         didSet {
//             clipsToBounds = clipsToBounds ? true : false
//         }
//     }

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {return nil}
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor  = newValue?.cgColor }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable
    var masksToBounds: Bool {
        get {return layer.masksToBounds }
            
        
        set { layer.masksToBounds = newValue }
    
}
}





   





