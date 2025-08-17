//
//  ContentView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("首页")
                }
                .tag(0)
            
            MarketView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("行情")
                }
                .tag(1)
            
            TradeView()
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                    Text("交易")
                }
                .tag(2)
            
            FuturesView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("合约")
                }
                .tag(3)
            
            AssetsView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("资产")
                }
                .tag(4)
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}