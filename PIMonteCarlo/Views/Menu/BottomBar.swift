//
//  BottomBar.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 18/12/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case statistics = "chart.bar"
    case house = "house"
    case description = "questionmark.circle"
}

struct BottomBar: View {
    
    @Binding var selectedTab: Tab
    
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1)
                        .font(.system(size: 22))
                        .foregroundStyle(selectedTab == tab ? .blue : .black)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

#Preview {
    BottomBar(selectedTab: .constant(.house))
}
