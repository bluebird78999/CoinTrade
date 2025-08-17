//
//  TradeMarketView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct TradeMarketView: View {
    @Binding var isPresented: Bool
    @State private var searchText = ""
    
    let categories = [
        CategoryItem(icon: "arrow.up.arrow.down", title: "移动服务"),
        CategoryItem(icon: "creditcard", title: "礼品卡"),
        CategoryItem(icon: "gamecontroller", title: "游戏"),
        CategoryItem(icon: "globe", title: "电子商务"),
        CategoryItem(icon: "airplane", title: "旅行")
    ]
    
    let hotProducts = [
        HotProduct(title: "热销爆品", subtitle: "立享低至五折的独家优惠并获取奖励", tag: "Hot"),
        HotProduct(title: "定投", subtitle: "Grow your crypto on autopilot", tag: ""),
        HotProduct(title: "BAB Token", subtitle: "Binance Account Bound Token", tag: ""),
        HotProduct(title: "Binance NFT", subtitle: "Explore Premium, Unique and Exclusive NFTs", tag: "")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Header with safe area
                headerView
                    .padding(.top, geometry.safeAreaInsets.top)
                
                // Scrollable content
                ScrollView {
                    VStack(spacing: 0) {
                        // Recent browsing section
                        recentBrowsingSection
                        
                        // Hot products section
                        hotProductsSection
                        
                        // Self-selection section
                        selfSelectionSection
                        
                        // Categories section
                        categoriesSection
                        
                        // Your exclusive section
                        exclusiveSection
                        
                        // Hot section
                        hotSection
                        
                        // Extra padding for bottom button
                        Color.clear
                            .frame(height: 80)
                    }
                }
                
                // Return to home button - fixed at bottom
                returnHomeButton
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .background(Color(UIColor.systemGray6))
            .ignoresSafeArea(.all)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: { isPresented = false }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text("交易市场")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                
                Button(action: {}) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var recentBrowsingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("最近浏览")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var hotProductsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "gift.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
                Text("热销爆品")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text("Hot")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var selfSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("自选")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
            
            Text("在常用小程序中添加⭐️图标，创建你最喜欢的快捷方式列表。")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("类别")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 20) {
                ForEach(categories, id: \.title) { category in
                    VStack(spacing: 8) {
                        Image(systemName: category.icon)
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                        
                        Text(category.title)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var exclusiveSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("您的专享")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "percent")
                        .font(.system(size: 16))
                        .foregroundColor(.orange)
                    
                    Text("低至 5 折折扣，尽在币安支付特惠活动")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "percent")
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(20)
                }
                
                Text("适用《条款与条件》")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var hotSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("热门")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 12) {
                ForEach(hotProducts, id: \.title) { product in
                    hotProductRow(product: product)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private func hotProductRow(product: HotProduct) -> some View {
        HStack {
            if product.title == "热销爆品" {
                Image(systemName: "gift.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.orange)
                    .frame(width: 40, height: 40)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
            } else if product.title == "定投" {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            } else if product.title == "BAB Token" {
                Image(systemName: "circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.yellow)
                    .frame(width: 40, height: 40)
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(8)
            } else {
                Image(systemName: "square.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.purple)
                    .frame(width: 40, height: 40)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(product.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    if !product.tag.isEmpty {
                        Text(product.tag)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
                
                Text(product.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
    
    private var returnHomeButton: some View {
        Button(action: { isPresented = false }) {
            HStack {
                Image(systemName: "house.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Text("返回首页")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

struct CategoryItem {
    let icon: String
    let title: String
}

struct HotProduct {
    let title: String
    let subtitle: String
    let tag: String
}

#Preview {
    TradeMarketView(isPresented: .constant(true))
}
