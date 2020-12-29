//
//  AnalyticsSwiftUIView.swift
//  Diplom(Finance)
//
//  Created by Юлия Чужинова on 27.12.2020.
//

import SwiftUI
import UIKit
//class AnalyticsSwiftUIView: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
        struct CircleShape: Shape {
            let progress: Double
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                            radius: rect.width / 2,
                            startAngle: .radians(1.5 * .pi),
                            endAngle: .init(radians: 2 * Double.pi * progress + 1.5 * Double.pi),
                            clockwise: false)
                return path
            }
            
        }


        struct AnalyticsSwiftUIView: View {
            @State var picketItem = 0
            var body: some View {
                ZStack {
                    Color(.lightGray).edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        Text("Аналитика").font(.system(size: 32)).fontWeight(.heavy)
                        Picker(selection: $picketItem, label: Text("")){
                            Text("Октябрь")
                            Text("Ноябрь")
                            Text("Декабрь")
                        }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16)
                        HStack{
                            CircleView(value: 0.3)
                            CircleView(value: 0.7)
                            CircleView(value: 0.4)
                            
                        }.padding(.top, 16)
                        HStack{
                            DiagramSwiftUIView()
                            DiagramSwiftUIView()
                            DiagramSwiftUIView()
                        }.padding(.top, 16)
                        Spacer()
                        
                    }
                }
            }
        }

        struct CircleView: View {
            var value: Double
            var body: some View {
                ZStack(alignment: .center) {
                    CircleShape(progress: 1).stroke(Color.white, style: StrokeStyle(lineWidth: 10,
                                                                                    lineCap: .butt,
                                                                                    lineJoin: .round,
                                                                                    miterLimit: 0,
                                                                                    dash: [],
                                                                                    dashPhase: 0))
                    CircleShape(progress: value).stroke(Color.red, style: StrokeStyle(lineWidth: 10,
                                                                                      lineCap: .round,
                                                                                      lineJoin: .round,
                                                                                      miterLimit: 0,
                                                                                      dash: [],
                                                                                      dashPhase: 0))
                    Text("\(Int(value * 100)) %")
                }.padding()
            }
        }
        struct DiagramSwiftUIView: View {
            var body: some View {
                ZStack {
                    ZStack(alignment: .bottom) {
                        
                        Rectangle().frame(width: 30, height: 200).foregroundColor(.white)
                        Rectangle().frame(width: 30, height: 100).foregroundColor(.blue)
                    }.padding(.top, 16)
                    Text("03").padding(.top, 4)
                    
                }
            }
        }

        struct AnalyticsSwiftUIView_Previews: PreviewProvider {
            static var previews: some View {
                AnalyticsSwiftUIView()
            }
        }
        
//    }
//
//}
