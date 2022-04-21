//
//  View-SandPlantsView.swift
//  Marine Life
//
//  Created by Patrick Battisti Forsthofer on 08/04/22.
//

import SwiftUI

struct SandPlantsView: View {
    var size: CGSize
    
    var midWidth: CGFloat {
        UIScreen.screenWidth / 2
    }
    
    var body: some View {
        ZStack {
            //   only ipad
            Group {
                Image("Plant11")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .position(x: midWidth - 475, y: 100)
                
                Image("Plant1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 125)
                    .position(x: midWidth - 475, y: -25)
                
                Image("Rock")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .position(x: midWidth - 400, y: 50)
                
                Image("Plant11")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 100)
                    .position(x: midWidth - 300, y: -15)
                
                Image("Plant10")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .position(x:  midWidth - 325, y: 100)
            }
            
            Group {
                Image("Plant6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 75)
                    .position(x: midWidth - 175, y: 0)
                
                Image("Plant12")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 70)
                    .position(x: midWidth - 175, y: 75)
                
                Image("Plant1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 125)
                    .position(x: midWidth - 50, y: -25)
                
                Image("Rock")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .position(x: midWidth - 50, y: 75)
             
            }
            
            //            middle
            
            Group {
                Image("Plant3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .position(x: midWidth + 30, y: 25)
                
                Image("Plant13")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .position(x: midWidth + 30, y: 100)
                
                
                Group {
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .position(x: midWidth + 100, y: 75)
                    
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .position(x: midWidth + 120, y: 85)
                }
                
                Image("Plant10")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 100)
                    .position(x: midWidth + 150, y: -15)
                
                Image("Plant11")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .position(x:  midWidth + 175, y: 100)
            }
            
//             only ipad
            Group {
                Image("Plant12")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 75)
                    .position(x: midWidth + 275, y: 0)
                
                Image("Plant6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 70)
                    .position(x: midWidth + 275, y: 75)
                
                Image("Plant11")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
                    .position(x:  midWidth + 400, y: 0)
                
                Group {
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .position(x: midWidth + 450, y: 100)
                    
                    Image("Rock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .position(x: midWidth + 470, y: 110)
                }
            }
        }
    }
}
