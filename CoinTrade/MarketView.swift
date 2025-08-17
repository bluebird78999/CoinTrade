//
//  MarketView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct MarketView: View {
    @State private var searchText = ""
    @State private var selectedTopTab = 0
    @State private var selectedBottomTab = 0
    
    let topTabs = ["自选", "行情", "Alpha", "金融增长", "广场", "数据"]
    let bottomTabs = ["全部", "持有币种", "现货", "Alpha", "合约", "期权"]
    
    let coinData = [
        CoinData(symbol: "BNB", pair: "/USDT", leverage: "10x", volume: "1.08亿", price: "850.01", usdPrice: "$850.01", change: "+2.10%", changeColor: .green),
        CoinData(symbol: "BTC", pair: "/USDT", leverage: "10x", volume: "6.99亿", price: "118,062.89", usdPrice: "$118,062.89", change: "+0.52%", changeColor: .green),
        CoinData(symbol: "ETH", pair: "/USDT", leverage: "10x", volume: "15.64亿", price: "4,479.94", usdPrice: "$4,479.94", change: "+1.27%", changeColor: .green),
        CoinData(symbol: "DOGE", pair: "/USDT", leverage: "10x", volume: "2.24亿", price: "0.2339", usdPrice: "$0.2339", change: "+1.21%", changeColor: .green),
        CoinData(symbol: "SOL", pair: "/USDT", leverage: "10x", volume: "3.94亿", price: "192.73", usdPrice: "$192.73", change: "+3.25%", changeColor: .green),
        CoinData(symbol: "SPK", pair: "/USDT", leverage: "5x", volume: "758.47万", price: "0.082619", usdPrice: "$0.082619", change: "-3.82%", changeColor: .red),
        CoinData(symbol: "LINK", pair: "/USDT", leverage: "5x", volume: "1.53亿", price: "24.38", usdPrice: "$24.38", change: "+12.66%", changeColor: .green),
        CoinData(symbol: "ADA", pair: "/USDT", leverage: "10x", volume: "2.52亿", price: "0.9491", usdPrice: "$0.9491", change: "-0.20%", changeColor: .red)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header with search
                headerView
                
                // Top tabs
                topTabsView
                
                // Bottom tabs
                bottomTabsView
                
                // Table header
                tableHeaderView
                
                // Coin list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(coinData) { coin in
                            coinRowView(coin: coin)
                            if coin.id != coinData.last?.id {
                                Divider()
                                    .padding(.leading, 16)
                            }
                        }
                    }
                }
                .background(Color.white)
            }
            .background(Color(UIColor.systemGray6))
        }
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                
                TextField("搜索币种/币对/合约", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
        .padding(.top, 8)
        .background(Color.white)
    }
    
    private var topTabsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<topTabs.count, id: \.self) { index in
                    Button(action: { selectedTopTab = index }) {
                        VStack(spacing: 4) {
                            Text(topTabs[index])
                                .font(.system(size: 14, weight: selectedTopTab == index ? .medium : .regular))
                                .foregroundColor(selectedTopTab == index ? .black : .gray)
                            
                            if selectedTopTab == index {
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(height: 2)
                            } else {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(height: 2)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .padding(.bottom, 8)
    }
    
    private var bottomTabsView: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<bottomTabs.count, id: \.self) { index in
                        Button(action: { selectedBottomTab = index }) {
                            Text(bottomTabs[index])
                                .font(.system(size: 14, weight: selectedBottomTab == index ? .medium : .regular))
                                .foregroundColor(selectedBottomTab == index ? .black : .gray)
                        }
                    }
                    
                    if bottomTabs[selectedBottomTab] == "持有币种" {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.horizontal, 16)
            }
            
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var tableHeaderView: some View {
        HStack {
            HStack {
                Text("名称")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Text("/ 成交额")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack {
                Text("最新价")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("24h涨跌幅")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .frame(width: 100, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    private func coinRowView(coin: CoinData) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(coin.symbol)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    Text(coin.pair)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(coin.leverage)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.gray)
                        .cornerRadius(4)
                }
                Text(coin.volume)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(coin.price)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text(coin.usdPrice)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Text(coin.change)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(coin.changeColor)
                .cornerRadius(4)
                .frame(width: 80, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

struct CoinData: Identifiable {
    let id = UUID()
    let symbol: String
    let pair: String
    let leverage: String
    let volume: String
    let price: String
    let usdPrice: String
    let change: String
    let changeColor: Color
}

#Preview {
    MarketView()
}
