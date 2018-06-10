//
//  ViewController.swift
//  FormzDemo
//
//  Created by Jonathan Sahoo on 6/1/18.
//  Copyright © 2018 Jonathan Sahoo. All rights reserved.
//

import UIKit
import Formz

class ViewController: UIViewController {

    @IBOutlet weak var formView: FormView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Setup FormView

        formView.spacing = 15
        // Set default appearance for all FormTextFields added to this FormView
        formView.titleFont = UIFont(name: "AvenirNext-Regular", size: 14)!
        formView.textFieldFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        formView.helperFont = UIFont(name: "AvenirNext-Regular", size: 10)!
        formView.activeTintColor = .black
        formView.inactiveTintColor = .darkGray
        formView.validationFailureTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        // By default the cursor will use the `activeTintColor`. Set `cursorTintColor` to change it.
        // formView.cursorTintColor = .blue

        // MARK: - Setup FormTextFields

        let firstNameField = FormTextField(identifier: "firstName")
        firstNameField.titleLabel.text = "First Name"
        firstNameField.validationRule = { text in
            // Valid IFF the String is non-empty and contains only letters
            return text?.isEmpty == false && (text?.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil)
        }
        firstNameField.textField.autocorrectionType = .no
        firstNameField.textField.autocapitalizationType = .words
        formView.addFormTextField(firstNameField)

        let lastNameField = FormTextField(identifier: "lastName")
        lastNameField.titleLabel.text = "Last Name"
        lastNameField.validationRule = { text in
            // Valid IFF the String is non-empty and contains only letters
            return text?.isEmpty == false && (text?.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil)
        }
        lastNameField.textField.autocorrectionType = .no
        lastNameField.textField.autocapitalizationType = .words
        formView.addFormTextField(lastNameField)

        let usernameField = FormTextField(identifier: "username")
        usernameField.titleLabel.text = "Username"
        usernameField.helperTextLabel.text = "Your username must be between 4 and 10 characters and cannot contain spaces or special characters."
        usernameField.helperTextLabel.isHidden = false
        usernameField.validationRule = { text in
            guard let text = text, 4 ... 10 ~= text.count else { return false }
            return text.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
        }
        usernameField.textField.autocorrectionType = .no
        usernameField.textField.autocapitalizationType = .none
        formView.addFormTextField(usernameField)

        // FormTextField with custom appearance (not inherited from parent `FormView`)
        // NOTE: when customizing individual form fields, any property that is not explictly set will default to `FormTextField`'s default value and *not* the parent `FormView`'s customizations.
        let passwordField = FormTextField(identifier: "password")
        passwordField.activeTintColor = .blue
        passwordField.inactiveTintColor = .purple
        passwordField.validationFailureTintColor = .orange
        passwordField.cursorTintColor = .black
        passwordField.titleLabel.text = "Password"
        passwordField.helperTextLabel.text = "Your password must be at least 8 characters."
        passwordField.helperTextLabel.isHidden = false
        passwordField.validationRule = { text in
            return (text?.count ?? 0) >= 8
        }
        passwordField.textField.isSecureTextEntry = true
        formView.addFormTextField(passwordField, customAppearance: true)
    }

    @IBAction func didTapSubmit(_ sender: UIButton) {
        guard formView.validateAllFields(), let username = formView.textFromFormField(withIdentifier: "username") else {
            let alert = UIAlertController(title: "Oops", message: "There's an error in your submission. Please go back and fix any mistakes and try again.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }

        let alert = UIAlertController(title: "Welcome, \(username)!", message: "Your account was successfully created.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Let's Get Started!", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

