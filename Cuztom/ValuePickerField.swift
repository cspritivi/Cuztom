import SwiftUI
import UIKit

struct HeightPickerField: UIViewRepresentable {
    @Binding var feet: Int
    @Binding var inches: Int
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.inputView = context.coordinator.inputView
        textField.tintColor = .clear
        textField.delegate = context.coordinator
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolBar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: context.coordinator, action: #selector(context.coordinator.doneButtonTapped))
        ], animated: false)
        textField.inputAccessoryView = toolBar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = "\(feet)' \(inches)\""
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: HeightPickerField
        var inputView: UIView!
        var feetPicker: UIPickerView!
        var inchesPicker: UIPickerView!
        
        init(_ parent: HeightPickerField) {
            self.parent = parent
            super.init()
            setupInputView()
        }
        
        func setupInputView() {
            feetPicker = UIPickerView()
            inchesPicker = UIPickerView()
            feetPicker.dataSource = self
            feetPicker.delegate = self
            inchesPicker.dataSource = self
            inchesPicker.delegate = self
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))
            containerView.backgroundColor = .systemBackground
            
            let stackView = UIStackView(arrangedSubviews: [feetPicker, inchesPicker])
            stackView.distribution = .fillEqually
            stackView.frame = containerView.bounds
            
            containerView.addSubview(stackView)
            
            inputView = containerView
            
            DispatchQueue.main.async {
                self.feetPicker.selectRow(max(0, min(self.parent.feet - 2, 6)), inComponent: 0, animated: false)
                self.inchesPicker.selectRow(max(0, min(self.parent.inches, 11)), inComponent: 0, animated: false)
            }
        }
        
        func updateHeight() {
            parent.feet = feetPicker.selectedRow(inComponent: 0) + 2
            parent.inches = inchesPicker.selectedRow(inComponent: 0)
        }
        
        @objc func doneButtonTapped() {
            updateHeight()
            if let textField = inputView.findViewController()?.view.findFirstResponder() as? UITextField {
                textField.resignFirstResponder()
            }
        }
        
        // UITextFieldDelegate method
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true // Allow editing, which will show the picker
        }
    }
}

extension HeightPickerField.Coordinator: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == feetPicker ? 7 : 12 // 2-8 feet, 0-11 inches
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == feetPicker {
            return "\(row + 2) ft"
        } else {
            return "\(row) in"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateHeight()
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        
        for subview in subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        
        return nil
    }
}
