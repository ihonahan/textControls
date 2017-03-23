//
//  AccessoryInputView.swift
//  textControls
//
//  Created by Ihonahan Buitrago on 3/22/17.
//  Copyright © 2017 Ihonahan Buitrago. All rights reserved.
//

import UIKit

class AccessoryInputView: UIView {

    @IBOutlet weak var fullContainer : UIView!
    @IBOutlet weak var textview : UITextView!
    @IBOutlet weak var doneButton : UIButton!

    class func loadFromNib() -> AccessoryInputView {
        var nibs = NSBundle.mainBundle().loadNibNamed("AccessoryInputView", owner: self, options: nil)
        let view = nibs?[0] as! AccessoryInputView
        return view
    }
    
}
