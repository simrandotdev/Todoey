//
//  SystemImageToolbarItem.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct SystemImageToolbarItem: ToolbarContent {
    
    var placement: ToolbarItemPlacement
    var systemImage: String
    var action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button {
                action()
            } label: {
                Image(systemName: systemImage)
            }
        }
    }
}

struct SystemImageToolbarItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar(content: {
                SystemImageToolbarItem(placement: .primaryAction, systemImage: "heart", action: {})
            })
        }
    }
}
