//
//  BottomView.swift
//  life tracking
//
//  Created by Rodrigo Santos on 25/07/20.
//  Copyright © 2020 Rodrigo Santos. All rights reserved.
//

import SwiftUI

// MARK: - Bottom View
struct HomeBottomView: View {
    /// Binding - Person
    @Binding var user: Person
    
    /// Binding - Coutry
    @Binding var country: Region?
    
    /// Binding - Person
    @Binding var isLogin: Bool
    @Binding var isSelectCountry: Bool
    
    /// States - Boolean
    @State private var bottomSheetShown = false
    
    
    var geometry: GeometryProxy
    
    
    var body: some View {
        VStack {
            if isSelectCountry {
                
                BottomSheetView(isOpen: self.$isSelectCountry, maxHeight: 450) {

                    VStack(alignment: .leading) {
                        Text("\(self.country?.localizedLongName ?? "")")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                        
                        ScrollView {
                            ForEach(self.country!.subRegions.indices) { index in
                                VStack {
                                    Text("\(self.country!.subRegions[index].localizedLongName)")
                                    Text("\(self.country!.subRegions[index].report?.stat.description ?? "")")
                                }
                                .frame(width: UIScreen.main.bounds.size.width)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width)
                    }
                    .padding(.bottom, 20)
                }
                .animation(.easeInOut)
                .edgesIgnoringSafeArea(.bottom)
                
            } else {
                VStack {
                    if (self.user.name != "") {
                        HomeBottomSheet(bottomSheetShown: self.$bottomSheetShown, geometry: geometry, user: self.$user)
                    } else {
                        HStack() {
                            Spacer()
                            Button(action: { self.isLogin.toggle() }) {
                                VStack {
                                    HStack {
                                        Image(systemName: "person.crop.circle.badge.exclam")
                                        Text("Você voltou ?")
                                    }
                                    .padding()
                                }
                                .background(
                                    BlurRepresentable(style: .regular)
                                        .cornerRadius(10)
                                )
                            }
                            Spacer()
                        }
                        .padding(.top, geometry.size.height - geometry.safeAreaInsets.bottom - 20)
                    }
                }
            }
        }
        .animation(.easeInOut)
        .animation(.spring())
    }
}

