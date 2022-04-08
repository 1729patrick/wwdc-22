//
//  View-WaterDropsView.swift
//  Save the animals
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct WaterDropsView: View {
    
    var body: some View {
        ZStack{
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 15, height: 15)
                .offset(x: -20)
            
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 15, height: 15)
                .offset(x: 40,y: 30)
            
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 25, height: 25)
                .offset(x: -30,y: 80)
            
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 25, height: 25)
                .offset(x: 50,y: 70)
            
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 10, height: 10)
                .offset(x: 40,y: 100)
            
            Circle()
                .fill(.white.opacity(0.1))
                .frame(width: 10, height: 10)
                .offset(x: -40,y: 50)
        }
    }
}
