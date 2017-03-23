//
//  ViewController.swift
//  textControls
//
//  Created by Ihonahan Buitrago on 3/20/17.
//  Copyright © 2017 Ihonahan Buitrago. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var fullContainer : UIView!
    
    @IBOutlet weak var topTextfield : UITextField!
    @IBOutlet weak var middleTextfield : UITextField!
    @IBOutlet weak var bottomTextfield : UITextField!
    
    @IBOutlet weak var bottomTextView : UITextView!
    
    @IBOutlet weak var fullContainerTopConstraint : NSLayoutConstraint!
    @IBOutlet weak var fullContainerBottomConstraint : NSLayoutConstraint!
    
    var keyboardHeight : CGFloat = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        self.topTextfield.text = "Lorem ipsum"
        
        self.bottomTextView.inputAccessoryView = AccessoryInputView.loadFromNib()
        if let input = self.bottomTextView.inputAccessoryView as? AccessoryInputView {
            input.doneButton.addTarget(self, action: #selector(ViewController.tapUpAccessoryDone(_:)), forControlEvents: .TouchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapUpAccessoryDone(sender: UIButton) {
        self.bottomTextView.resignFirstResponder()
    }

    
    //MARK: - Keyboard notifications methods
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let value = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
            let frame = value.CGRectValue()
            self.keyboardHeight = frame.size.height
        }
    }


    func animateUpFullContainerForKeyboard(textField: UITextField) {
        let yPosition = textField.frame.origin.y + textField.frame.size.height + 10
        
        let keyHeight = self.view.frame.size.height - self.keyboardHeight
        
        if yPosition > keyHeight {
            let moved = keyHeight - yPosition - textField.frame.size.height
            self.moveFullContainer(moved)
        }
    }

    func animateDownFullContainerForKeyboard() {
        self.moveFullContainer(0)
    }

    
    func moveFullContainer(toConstant: CGFloat) {
        self.fullContainerTopConstraint.constant = toConstant
        self.fullContainerBottomConstraint.constant = -toConstant
        
        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: - UITextFieldDelegate methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.animateUpFullContainerForKeyboard(textField)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.animateDownFullContainerForKeyboard()
        
        return true
    }
    
    
    //MARK: - UITextViewDelegate methods
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let initialText = NSString(string: textView.text)
        let result = initialText.stringByReplacingCharactersInRange(range, withString: text)
        
        if let input = textView.inputAccessoryView as? AccessoryInputView {
            input.textview.text = result
        }
        
        return true
    }
    

    

    

}

