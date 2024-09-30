//
//  RatingFace.swift
//  RatingAnimatedFace
//
//  Created by Shishir_Mac on 30/9/24.
//

import SwiftUI

struct RatingFace: View {
    
    @State var value: CGFloat = 0.5
    
    var body: some View {
        VStack {
            Text("Do you like this Life?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 25) {
                ForEach(1...2, id: \.self) { _ in
                    ZStack {
                        Eyes()
                            .stroke(Color.black, lineWidth: 4)
                            .frame(width: 100)
                        Eyes(value: value)
                            .stroke(Color.black, lineWidth: 4)
                            .frame(width: 100)
                            .rotationEffect(.init(degrees: 180))
                            .offset(y: -100)
                        
                        Circle()
                            .fill(Color.black)
                            .frame(width: 14, height: 14)
                            .offset(y: -30)
                        
                    }
                    .frame(height: 100)
                }
                
            }
            
            Smile(value: value)
                .stroke(Color.black, lineWidth: 4)
                .frame(height: 100)
            
            GeometryReader { reader in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Color.black
                        .frame(height: 1)
                    
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                        .offset(x: value * (reader.frame(in: .global).width) - 45)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    let width = reader.frame(in: .global).width - 45
                                    let drag = value.location.x - 30
                                    
                                    if drag > 0 && drag <= width {
                                        self.value = drag / width
                                    }
                                })
                        )
                }
            }
            .padding()
            .frame(height: 50)
            
            Spacer(minLength: 0)
            
            Button {
                print("Done")
            } label: {
                Text("Done")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: 200)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
        }
        .background(
            (value <= 0.3 ? Color("Color1") : (value > 0.3 && value <= 0.7 ? Color("Color2"): Color("Color3")))
                .ignoresSafeArea()
                .animation(.easeInOut)
        )
    }
}

struct RatingFace_Previews: PreviewProvider {
    static var previews: some View {
        RatingFace()
    }
}


// MARK: - Eyes View

struct Eyes: Shape {
    var value: CGFloat?
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = rect.width / 2
            let downRadius: CGFloat = 55 * (value ?? 1)
            
            path.move(to: CGPoint(x: center - 40, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let con1 = CGPoint(x: center - 40, y: 0)
            let con2 = CGPoint(x: center - 40, y: downRadius)
            
            let to2 = CGPoint(x: center + 40, y: 0)
            let con3 = CGPoint(x: center + 40, y: downRadius)
            let con4 = CGPoint(x: center + 40, y: 0)
            
            path.addCurve(to: to1, control1: con1, control2: con2)
            path.addCurve(to: to2, control1: con3, control2: con4)
        }
    }
}

// MARK: - Smile view
struct Smile: Shape {
    var value: CGFloat
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = rect.width / 2
            let downRadius: CGFloat = (115 * value) - 45
            
            path.move(to: CGPoint(x: center - 150, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let con1 = CGPoint(x: center - 145, y: 0)
            let con2 = CGPoint(x: center - 145, y: downRadius)
            
            let to2 = CGPoint(x: center + 150, y: 0)
            let con3 = CGPoint(x: center + 145, y: downRadius)
            let con4 = CGPoint(x: center + 145, y: 0)
            
            path.addCurve(to: to1, control1: con1, control2: con2)
            path.addCurve(to: to2, control1: con3, control2: con4)
        }
    }
}
