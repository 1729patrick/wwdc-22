//
//  View-SandPlantsView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct SandPlantsView: View {
    var size: CGSize
    
    var width: CGFloat {
        UIScreen.screenWidth
    }
    
    var height: CGFloat {
        UIScreen.screenHeight * 0.15
    }
    
    var scale: CGFloat {
        if UIDevice.isIPad {
            return UIScreen.screenWidth / 520
        }
        
        return UIScreen.screenWidth / 420
    }
    
    var body: some View {
        ZStack {
            Group {
                Image("Plant6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 75 * scale)
                    .position(x: width * 0.07, y: 0)
                
                Image("Plant12")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 70 * scale)
                    .position(x: width * 0.12, y: height * 0.6)
                
                Image("Plant1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 125 * scale)
                    .position(x: width * 0.35, y: -height * 0.16)
                
                Image("Rock")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25 * scale, height: 25 * scale)
                    .position(x: width * 0.4, y: height * 0.55)
            }
            
            //            middle
            
            Group {
                Image("Plant3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 50 * scale)
                    .position(x: width * 0.6, y: height * 0.16)
                
                Image("Plant13")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 50 * scale)
                    .position(x: width * 0.6, y: height * 0.66)
                
                
                ZStack(alignment: .bottomTrailing){
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50 * scale, height: 50 * scale)
                    
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30 * scale, height: 30 * scale)
                        .offset(x: 10)
                }
                .position(x: width * 0.75, y: height * 0.5)
                
                Image("Plant10")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50 * scale, height: 85 * scale)
                    .position(x: width * 0.9, y: -height * 0.1)
                
                Image("Plant11")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50 * scale, height: 50 * scale)
                    .position(x:  width * 0.95, y: height * 0.66)
            }
        }
    }
}
