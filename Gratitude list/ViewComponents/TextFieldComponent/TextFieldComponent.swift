//
//  TextFieldComponent.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct TextFieldComponent: View {
    /// A binding to the text that is typed inside the text field
    private var text: Binding<String>
    
    /// A binding to the error text
    private var errorText: Binding<String>?
    
    /// A text representing the placeholder text of what the user should enter inside the text field
    /// This text will be visible inside of the text field if any value is given
    private let placeholder: String
    
    /// Image shown on the left side of the textfield
    private let logoImageName: String
    
    /// A text representing the title label or description of the textfield
    private let label: String
    
    /// A callback function that will be called when the user taps the keyboard 'return' button
    fileprivate var handleReturnAction: FunctionCallback?
    
    /// An action to perform when editing on the textfield begins
    fileprivate var onBeginEditigAction: FunctionCallback?
    
    /// An action to perform when editing on the textfield ends
    fileprivate var onEndEditingAction: FunctionCallback?
    
    /// Set focus state for textfield
    @FocusState fileprivate var isFocused: Bool
    
    public init(
        placeholder: String = "",
        text: Binding<String>,
        errorText: Binding<String>? = nil,
        logoImageName: String = "",
        label: String = ""
    ) {
        self.placeholder = placeholder
        self.text = text
        self.errorText = errorText
        self.logoImageName = logoImageName
        self.label = label
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !label.isEmpty {
                Text(label)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(alignment: .center, spacing: 8) {
           
                if let errorText = errorText, errorText.wrappedValue.isEmpty {
                    Image(systemName: logoImageName).padding(1)
                } else {
                    Image(systemName: "exclamationmark.triangle").padding(1).foregroundColor(.red)
                }
                
                TextField(placeholder, text: text)
                    .focused($isFocused)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: isFocused) { oldValue, newValue in
                        newValue ? onBeginEditigAction?() : onEndEditingAction?()
                    }
                    .onSubmit {
                        isFocused = false
                        
                        handleReturnAction?()
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
            .background(.black.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(.black.opacity(0.3),
                            lineWidth: isFocused ? 1 : 0)
            )
            .onTapGesture {
                isFocused = true
            }
            
            if let errorText = errorText {
                Text(errorText.wrappedValue)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

extension TextFieldComponent {
    func handleReturn(action: @escaping FunctionCallback) -> Self {
        var newSelfInstance = self
        newSelfInstance.handleReturnAction = action
        
        return newSelfInstance
    }
    
    func onBeginEditing(action: @escaping FunctionCallback) -> Self {
        var newSelfInstance = self
        newSelfInstance.onBeginEditigAction = action
        
        return newSelfInstance
    }
    
    func onEndEditing(action: @escaping FunctionCallback) -> Self {
        var newSelfInstance = self
        newSelfInstance.onEndEditingAction = action
        
        return newSelfInstance
    }
}
