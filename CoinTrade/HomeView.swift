//
//  HomeView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct HomeView: View {
    @Binding var showingTradeMarket: Bool
    @State private var searchText = ""
    @State private var selectedSegment = 0
    @State private var selectedFilter = 0
    
    init(showingTradeMarket: Binding<Bool> = .constant(false)) {
        self._showingTradeMarket = showingTradeMarket
    }
    
    let segments = ["自选", "热门", "Alpha", "新币上线", "涨幅榜", "跌幅榜"]
    let filters = ["全部", "现货"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6).ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Header
                        headerView
                        
                        // Balance Section
                        balanceSection
                        
                        // Financial Products Section
                        financialProductsSection
                        
                        // Recommended Products Section
                        recommendedSection
                        
                        // Market Section
                        marketSection
                        
                        // Bottom tabs
                        bottomTabsSection
                        
                        // Coin list
                        coinListSection
                    }
                }
                .refreshable {
                    // 下拉刷新时显示交易市场
                    showingTradeMarket = true
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {}) {
                HStack(spacing: 4) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                    Circle()
                        .fill(Color.red)
                        .frame(width: 6, height: 6)
                }
            }
            
            Button(action: {}) {
                Image(systemName: "message")
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text("交易平台")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Text("钱包")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "headphones")
                    .foregroundColor(.black)
            }
            
            Button(action: {}) {
                Image(systemName: "bell")
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .background(Color.white)
    }
    
    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("预估总资产 (BTC)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.up")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Text("0.00001692")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("≈ $1.99")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("今日盈亏")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("+$0.00(+0.00%)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("添加资金")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                        .cornerRadius(20)
                }
            }
        }
        .padding(16)
        .background(Color.white)
    }
    
    private var financialProductsSection: some View {
        VStack(spacing: 0) {
            HStack {
                VStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                    Text("赚取高达 12.02% 的 USDC 年化收益率")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {}) {
                    Text("申购")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black)
                        .cornerRadius(16)
                }
            }
            .padding(16)
            .background(Color.yellow)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }
    
    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("理财")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("$0")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Text("预估总资产")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$0.00")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Text("昨日收益")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            Text("推荐")
                .font(.system(size: 16, weight: .medium))
                .padding(.top, 8)
            
            VStack(spacing: 12) {
                recommendedProductRow(icon: "dollarsign.circle.fill", name: "USDC", tag: "奖励", rate: "12.02%", subtitle: "最高年化")
                recommendedProductRow(icon: "e.circle.fill", name: "ETH", tag: "奖励", rate: "2.46%", subtitle: "最高年化")
            }
        }
        .padding(16)
        .background(Color.white)
    }
    
    private func recommendedProductRow(icon: String, name: String, tag: String, rate: String, subtitle: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(name)
                        .font(.system(size: 16, weight: .medium))
                    Text(tag)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(rate)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Button(action: {}) {
                Text("申购")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black)
                    .cornerRadius(12)
            }
        }
    }
    
    private var marketSection: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 16)
        }
    }
    
    private var bottomTabsSection: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<segments.count, id: \.self) { index in
                        Button(action: { selectedSegment = index }) {
                            VStack(spacing: 4) {
                                Text(segments[index])
                                    .font(.system(size: 14, weight: selectedSegment == index ? .medium : .regular))
                                    .foregroundColor(selectedSegment == index ? .black : .gray)
                                
                                if selectedSegment == index {
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
            
            HStack {
                HStack(spacing: 12) {
                    ForEach(0..<filters.count, id: \.self) { index in
                        Button(action: { selectedFilter = index }) {
                            Text(filters[index])
                                .font(.system(size: 14, weight: selectedFilter == index ? .medium : .regular))
                                .foregroundColor(selectedFilter == index ? .black : .gray)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            HStack {
                Text("名称")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("最新价")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text("24h涨跌幅")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .frame(width: 80, alignment: .trailing)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(Color.white)
    }
    
    private var coinListSection: some View {
        VStack(spacing: 0) {
            coinRow(symbol: "BNB", pair: "/USDT", volume: "1.08亿", price: "850.06", change: "+2.12%", changeColor: .green)
            
            Divider()
                .padding(.leading, 16)
            
            // Bottom navigation section
            VStack(spacing: 16) {
                HStack(spacing: 40) {
                    VStack(spacing: 8) {
                        Text("发现")
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                        Image(systemName: "house")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        Text("首页")
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                    }
                    
                    VStack(spacing: 8) {
                        Text("关注")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                        Text("行情")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(spacing: 8) {
                        Text("活动")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                        Text("交易")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(spacing: 8) {
                        Text("新闻")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Image(systemName: "doc.text")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                        Text("合约")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(spacing: 8) {
                        Text("公告")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Image(systemName: "creditcard")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                        Text("资产")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.vertical, 16)
            .background(Color.white)
        }
    }
    
    private func coinRow(symbol: String, pair: String, volume: String, price: String, change: String, changeColor: Color) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(symbol)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    Text(pair)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("10x")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.gray)
                        .cornerRadius(4)
                }
                Text(volume)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(price)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text("$" + price)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Text(change)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(changeColor)
                .cornerRadius(4)
                .frame(width: 80, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

#Preview {
    HomeView()
}
