//
//  RoundedPlusButton.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import SwiftUI

struct RoundedSystemImageToolbarItem: ToolbarContent {
    
    var placement: ToolbarItemPlacement
    var systemImageName: String
    var action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button {
                action()
            } label: {
                Circle()
                    .frame(width: 64, height: 64)
                    .overlay {
                        Image(systemName: systemImageName)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                    }
            }
        }
    }
}

struct RoundedPlusButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar(content: {
                RoundedSystemImageToolbarItem(placement: .bottomBar, systemImageName: "plus", action: {})
            })
        }
    }
}
