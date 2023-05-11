//
//  FormButton.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct FormButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Section {
            Button {
                action()
            } label: {
                Text(NSLocalizedString(title, comment: ""))
            }
            
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
        }
    }
}

struct FormButton_Previews: PreviewProvider {
    static var previews: some View {
        FormButton(title: "Save", action: {})
    }
}
