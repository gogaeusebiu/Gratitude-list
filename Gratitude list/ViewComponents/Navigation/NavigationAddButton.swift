//
//  NavigationAddButton.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

typealias FunctionCallback = (() -> Void)

struct NavigationImageButton: View {
    /// Image system name
    let systemName: String
    
    /// A callback function that will be called when the user taps the keyboard 'return' button
    fileprivate var handleAction: FunctionCallback?
    
    init(systemName: String) {
        self.systemName = systemName
    }
    
    var body: some View {
        Button {
            handleAction?()
        } label: {
            Image(systemName: systemName)
        }
    }
}

extension NavigationImageButton {
    func tapAction(action: @escaping FunctionCallback) -> Self {
        var newSelfInstance = self
        newSelfInstance.handleAction = action
        
        return newSelfInstance
    }
}
