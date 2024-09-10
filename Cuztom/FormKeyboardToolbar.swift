////
////  FormKeyboardToolbar.swift
////  Cuztom
////
////  Created by Pritivi S Chhabria on 9/9/24.
////
//
import Foundation
import SwiftUI

struct FormKeyboardToolBar: View {
    
    @FocusState private var focusedField = Field?
    
    var body: some View {
        Button(action: moveToPreviousField) {
            Image(systemName: "chevron.up")
        }
    }
    
    private func moveToPreviousField() {
        guard let currentFocus = focusedField, currentFocus.rawValue > 0 else { return }
        focusedField = Field(rawValue: currentFocus.rawValue - 1)
    }
    
    
    
}

//struct FormKeyboardToolbar: View {
//    
//        Button(action: moveToPreviousField) {
//            Image(systemName: "chevron.up")
//        }
//        .disabled(!canMoveToPreviousField)
//        
//        Button(action: moveToNextField) {
//            Image(systemName: "chevron.down")
//        }
//        .disabled(!canMoveToNextField)
//    }
//
//    private var canMoveToPreviousField: Bool {
//        guard let currentFocus = focusedField else { return false }
//        return currentFocus.rawValue > 0
//    }
//    
//    private var canMoveToNextField: Bool {
//        guard let currentFocus = focusedField else { return false }
//        return currentFocus.rawValue < Field.allCases.count - 1
//    }
//    

//    
//    private func moveToNextField() {
//        guard let currentFocus = focusedField, currentFocus.rawValue < Field.allCases.count - 1 else { return }
//        focusedField = Field(rawValue: currentFocus.rawValue + 1)
//    }
//    
//}
//
//ToolbarItemGroup(placement: .keyboard) {
//                    
//            }
//
//
