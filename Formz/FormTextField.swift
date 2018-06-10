//
//  FormTextField.swift
//  Formz
//
//  Created by Jonathan Sahoo on 6/1/18.
//  Copyright © 2018 Jonathan Sahoo. All rights reserved.
//

import Foundation

public class FormTextField: UIView {

    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var textField: UITextField!
    @IBOutlet public weak var helperTextLabel: UILabel!

    /// The validation logic to perform on the text field to determine whether its contents are valid or not. Return `true` if the contents are valid, `false` otherwise.
    public var validationRule: ((String?) -> Bool) = { _ in
        return true
    }

    public var identifier: String?
    /// The color of the title, helper text, and text field border when the text field is active.
    public var activeTintColor = UIColor.black
    /// The color of the title, helper text, and text field border when the text field is inactive.
    public var inactiveTintColor = UIColor.gray
    /// The color of the title, helper text, and text field border when the text field's contents are invalid.
    public var validationFailureTintColor = UIColor.red
    /// The color of the cursor. Uses the `activeTintColor` by default.
    public var cursorTintColor: UIColor?

    private var textFieldBorder: UIView?

    public convenience init(identifier: String) {
        self.init()
        self.identifier = identifier
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        loadViewFromNib("FormTextField")
        titleLabel.text = nil
        textField.text = nil
        helperTextLabel.text = nil
        helperTextLabel.isHidden = true
        let border = UIView()
        let borderThickness: CGFloat = 0.5
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0,
                              y: textField.frame.size.height - borderThickness,
                              width: textField.frame.size.width,
                              height: borderThickness)
        textFieldBorder = border
        textField.addSubview(border)
        applyColors()
    }

    internal func applyColors() {
        titleLabel.textColor = inactiveTintColor
        textFieldBorder?.backgroundColor = inactiveTintColor
        textField.textColor = activeTintColor
        helperTextLabel.textColor = inactiveTintColor
        textField.tintColor = cursorTintColor ?? activeTintColor
    }

    @IBAction func editingDidBegin(_ sender: UITextField) {
        titleLabel.textColor = activeTintColor
        textFieldBorder?.backgroundColor = activeTintColor
        textField.textColor = activeTintColor
        helperTextLabel.textColor = activeTintColor
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        if validationRule(textField.text) == true {
            titleLabel.textColor = inactiveTintColor
            textFieldBorder?.backgroundColor = inactiveTintColor
            helperTextLabel.textColor = inactiveTintColor
        } else {
            titleLabel.textColor = validationFailureTintColor
            textFieldBorder?.backgroundColor = validationFailureTintColor
            textField.textColor = validationFailureTintColor
            helperTextLabel.textColor = validationFailureTintColor
        }
    }
}
