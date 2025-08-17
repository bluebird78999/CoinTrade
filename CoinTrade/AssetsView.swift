//
//  AssetsView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct AssetsView: View {
    @State private var selectedTab = 0
    @State private var selectedAssetTab = 0
    
    let tabs = ["总览", "资金", "现货"]
    let assetTabs = ["币种", "账户"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Header tabs with safe area
                headerView
                    .padding(.top, geometry.safeAreaInsets.top)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Balance section
                        balanceSection
                        
                        // Action buttons
                        actionButtonsSection
                        
                        // Asset tabs
                        assetTabsSection
                        
                        // Asset list
                        assetListSection
                        
                        // Extra space for better scrolling
                        Color.clear
                            .frame(height: 100)
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            .ignoresSafeArea(.all, edges: .top)
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 30) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: { selectedTab = index }) {
                    VStack(spacing: 4) {
                        Text(tabs[index])
                            .font(.system(size: 16, weight: selectedTab == index ? .medium : .regular))
                            .foregroundColor(selectedTab == index ? .black : .gray)
                        
                        if selectedTab == index {
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
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("预估总资产")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Image(systemName: "eye.slash")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("0.00001692")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        Text("BTC")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
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
                
                VStack(spacing: 8) {
                    Button(action: {}) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
    }
    
    private var actionButtonsSection: some View {
        HStack(spacing: 12) {
            Button(action: {}) {
                Text("添加资金")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.yellow)
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                Text("转账")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                Text("划转")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(Color.white)
    }
    
    private var assetTabsSection: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(spacing: 20) {
                    ForEach(0..<assetTabs.count, id: \.self) { index in
                        Button(action: { selectedAssetTab = index }) {
                            VStack(spacing: 4) {
                                Text(assetTabs[index])
                                    .font(.system(size: 14, weight: selectedAssetTab == index ? .medium : .regular))
                                    .foregroundColor(selectedAssetTab == index ? .black : .gray)
                                
                                if selectedAssetTab == index {
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
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.white)
    }
    
    private var assetListSection: some View {
        VStack(spacing: 0) {
            // USDC row
            assetRow(
                icon: "dollarsign.circle.fill",
                iconColor: .blue,
                symbol: "USDC",
                name: "USDC",
                balance: "2.00",
                btcBalance: "0.00001692 BTC",
                showButtons: true
            )
            
            // Empty state for other assets
            Spacer()
        }
        .background(Color.white)
    }
    
    private func assetRow(icon: String, iconColor: Color, symbol: String, name: String, balance: String, btcBalance: String, showButtons: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(iconColor)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(symbol)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text(name)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(balance)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text(btcBalance)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            if showButtons {
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Text("理财")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                    }
                    
                    Button(action: {}) {
                        Text("交易")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}

#Preview {
    AssetsView()
}
