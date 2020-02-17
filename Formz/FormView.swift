//
//  FormView.swift
//  Formz
//
//  Created by Jonathan Sahoo on 6/1/18.
//  Copyright © 2018 Jonathan Sahoo. All rights reserved.
//

import UIKit

/// The view containing all form elements.
public class FormView: UIStackView {

    /// The default title font for all `FormTextFields` added to this `FormView`.
    public var titleFont = UIFont.systemFont(ofSize: 14)
    /// The default text field font for all `FormTextFields` added to this `FormView`.
    public var textFieldFont = UIFont.systemFont(ofSize: 17)
    /// The default helper font for all `FormTextFields` added to this `FormView`.
    public var helperFont = UIFont.systemFont(ofSize: 10)

    /// The default color of the title, helper text, and text field border when the text field is active for all `FormTextFields` added to this `FormView`.
    public var activeTintColor = UIColor.black
    /// The default color of the title, helper text, and text field border when the text field is inactive for all `FormTextFields` added to this `FormView`.
    public var inactiveTintColor = UIColor.gray
    /// The default color of the title, helper text, and text field border when the text field's contents are invalid for all `FormTextFields` added to this `FormView`.
    public var validationFailureTintColor = UIColor.red
    /// The default color of the cursor for all `FormTextFields` added to this `FormView`. Uses the `activeTintColor` by default.
    public var cursorTintColor: UIColor?

    private var formFields: [FormTextField] {
        return arrangedSubviews.compactMap { $0 as? FormTextField }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        axis = .vertical
    }

    /// Add a `FormTextField` to this `FormView`. By default, its appearance will reflect the default values specified by this `FormView`. To preserve appearance customizations applied directly to the `FormTextField`, use `customAppearance: false`
    public func addFormTextField(_ formTextField: FormTextField, customAppearance: Bool = false) {
        defer {
            formTextField.applyColors()
            addArrangedSubview(formTextField)
        }
        guard !customAppearance else { return }
        formTextField.titleLabel.font = titleFont
        formTextField.textField.font = textFieldFont
        formTextField.helperTextLabel.font = helperFont
        formTextField.activeTintColor = activeTintColor
        formTextField.inactiveTintColor = inactiveTintColor
        formTextField.validationFailureTintColor = validationFailureTintColor
        formTextField.cursorTintColor = cursorTintColor ?? activeTintColor
    }

    /// Validate all of the fields in the `FormView`. Returns an array of tuples containing the identifier of the invalid field and an error message for each invalid field.
    public func validateAllFields() -> [(String, String)] {
        var results = [(String, String)]()
        formFields.forEach {
            if let errorString = $0.validationRule($0.textField.text) {
                results.append(($0.identifier!, errorString))
            }
        }
        return results
    }

    /// Returns the `FormTextField` for the given identifier
    public func formField(withIdentifier identifier: String) -> FormTextField? {
        return formFields.first(where: { $0.identifier == identifier })
    }

    /// Returns the entered text from the `FormTextField` for the given identifier
    public func textFromFormField(withIdentifier identifier: String) -> String? {
        return formField(withIdentifier: identifier)?.textField.text
    }
}
