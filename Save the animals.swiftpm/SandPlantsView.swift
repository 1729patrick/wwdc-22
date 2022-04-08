//
//  SandPlantsView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct SandPlantsView: View {
    var size: CGSize
    
    var body: some View {
        ZStack {
            Text("🪷")
                .font(.system(size: 70))
                .position(x: 50, y: 200)
            
            Text("🪸")
                .font(.system(size: 50))
                .position(x: 30, y: 120)
            
            
            Text("🌵")
                .font(.system(size: 100))
                .position(x: 150, y: 100)
            
            Text("🪷")
                .font(.system(size: 30))
                .position(x: size.width / 2 - 30, y: 200)
            
            
            Group {
                Text("🪨")
                    .font(.system(size: 25))
                    .position(x: size.width / 2 + 30, y: 140)
            }
            
            Group {
                Text("🪨")
                    .font(.system(size: 50))
                    .position(x: size.width - 150, y: 200)
                
                Text("🪨")
                    .font(.system(size: 30))
                    .position(x: size.width - 130, y: 220)
            }
            
            Text("🪸")
                .font(.system(size: 100))
                .position(x: size.width - 50, y: 100)
            
            Text("🪷")
                .font(.system(size: 50))
                .position(x: size.width - 50, y: 180)
            
            
        }
    }
}
