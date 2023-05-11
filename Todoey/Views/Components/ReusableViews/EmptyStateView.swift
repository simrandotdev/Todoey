//
//  EmptyStateView.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct EmptyStateView: View {
    
    var systemImageName: String
    var message: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .font(.system(size: 64))
            Text(message)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.gray)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(systemImageName: "note", message: "Your list is empty. \nPlease create some todos")
    }
}
