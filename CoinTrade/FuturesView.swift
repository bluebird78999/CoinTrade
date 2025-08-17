//
//  FuturesView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct FuturesView: View {
    @State private var selectedTab = 0
    @State private var selectedOrderType = 0
    @State private var selectedPositionMode = 0
    @State private var selectedLeverage = "20x"
    @State private var selectedOrderTab = 1
    @State private var priceText = "118003.5"
    @State private var quantityText = ""
    @State private var stopLoss = false
    @State private var reduceOnly = false
    
    let tabs = ["U本位", "币本位", "期权", "跟明钱"]
    let orderTypes = ["限价单", "市价单"]
    let positionModes = ["全仓", "逐仓"]
    let orderTabs = ["买入/做多", "卖出/做空"]
    
    let orderBookData = [
        FuturesOrderItem(price: "118,004.8", quantity: "0.002"),
        FuturesOrderItem(price: "118,004.4", quantity: "0.044"),
        FuturesOrderItem(price: "118,003.9", quantity: "0.001"),
        FuturesOrderItem(price: "118,003.8", quantity: "0.004"),
        FuturesOrderItem(price: "118,003.7", quantity: "0.059"),
        FuturesOrderItem(price: "118,003.6", quantity: "0.792"),
        FuturesOrderItem(price: "118,003.5", quantity: "4.222", isCurrent: true),
        FuturesOrderItem(price: "118,003.4", quantity: "17.006"),
        FuturesOrderItem(price: "118,003.3", quantity: "0.003"),
        FuturesOrderItem(price: "118,003.2", quantity: "0.001"),
        FuturesOrderItem(price: "118,003.1", quantity: "0.618"),
        FuturesOrderItem(price: "118,003.0", quantity: "0.002"),
        FuturesOrderItem(price: "118,002.9", quantity: "0.002"),
        FuturesOrderItem(price: "118,002.7", quantity: "0.106")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Trading pair info with announcement
                tradingPairView
                
                HStack(spacing: 0) {
                    // Order book
                    orderBookView
                        .frame(maxWidth: .infinity)
                    
                    // Trading panel
                    tradingPanelView
                        .frame(maxWidth: .infinity)
                }
                
                // Welcome banner
                welcomeBannerView
                
                // Bottom section
                bottomSectionView
                
                Spacer()
            }
            .background(Color(UIColor.systemGray6))
        }
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        HStack(spacing: 20) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: { selectedTab = index }) {
                    HStack {
                        Text(tabs[index])
                            .font(.system(size: 16, weight: selectedTab == index ? .medium : .regular))
                            .foregroundColor(selectedTab == index ? .black : .gray)
                        if tabs[index] == "跟明钱" {
                            Text("New")
                                .font(.system(size: 8))
                                .foregroundColor(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color.orange)
                                .cornerRadius(4)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var tradingPairView: some View {
        VStack(spacing: 0) {
            // Announcement banner
            HStack {
                Image(systemName: "speaker.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
                
                Text("新交易对: 币安Alpha和币安合约将上线Reservoir (DAM) (2025-08-...")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.yellow.opacity(0.3))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("BTCUSDT")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        Text("永续")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.gray)
                            .cornerRadius(4)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    Text("+0.50%")
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("0.00 USDT")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.yellow)
                }
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Image(systemName: "chart.bar")
                            .foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Image(systemName: "percent")
                            .foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
        }
    }
    
    private var orderBookView: some View {
        VStack(spacing: 0) {
            // Trading info
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("资金费率 / 倒计时")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                    Text("0.0047% / 01:40:00")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    HStack {
                        Text("全仓")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Text("20x")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Text("单")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemGray6))
            
            // Price and quantity headers
            HStack {
                Text("价格")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("(USDT)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("数量")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("(BTC)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text("可用")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            
            // Order book items
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(orderBookData.indices, id: \.self) { index in
                        let item = orderBookData[index]
                        futuresOrderBookRow(item: item, isAboveCurrent: index < 6)
                    }
                }
            }
            .frame(maxHeight: 300)
            
            // Depth selector
            HStack {
                Text("0.1")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Image(systemName: "chevron.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(spacing: 2) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 12, height: 2)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 12, height: 2)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
        }
        .background(Color.white)
    }
    
    private func futuresOrderBookRow(item: FuturesOrderItem, isAboveCurrent: Bool) -> some View {
        HStack {
            Text(item.price)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(item.isCurrent ? .white : 
                               isAboveCurrent ? .red : .green)
            
            Spacer()
            
            Text(item.quantity)
                .font(.system(size: 12))
                .foregroundColor(item.isCurrent ? .white : .black)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
        .background(item.isCurrent ? Color.gray : 
                   isAboveCurrent ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
    }
    
    private var tradingPanelView: some View {
        VStack(spacing: 0) {
            // Buy/Sell toggle
            HStack(spacing: 0) {
                Button(action: { selectedOrderTab = 0 }) {
                    Text("买入/做多")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(selectedOrderTab == 0 ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selectedOrderTab == 0 ? Color.green : Color(UIColor.systemGray6))
                }
                
                Button(action: { selectedOrderTab = 1 }) {
                    Text("卖出/做空")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(selectedOrderTab == 1 ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selectedOrderTab == 1 ? Color.red : Color(UIColor.systemGray6))
                }
            }
            .cornerRadius(8)
            .padding(.horizontal, 12)
            .padding(.top, 8)
            
            // Order type selector
            Picker("Order Type", selection: $selectedOrderType) {
                ForEach(0..<orderTypes.count, id: \.self) { index in
                    Text(orderTypes[index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 12)
            .padding(.top, 8)
            
            VStack(spacing: 12) {
                // Price input
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("价格 (USDT)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("最优价")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Button(action: {}) {
                            Image(systemName: "minus")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    TextField("118003.5", text: $priceText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Quantity input
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("数量 (BTC)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("BTC")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    TextField("", text: $quantityText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Options
                VStack(spacing: 8) {
                    HStack {
                        Button(action: { stopLoss.toggle() }) {
                            HStack {
                                Image(systemName: stopLoss ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(.gray)
                                Text("止盈/止损")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: { reduceOnly.toggle() }) {
                            HStack {
                                Image(systemName: reduceOnly ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(.gray)
                                Text("只减仓")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Text("GTC")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                }
                
                // Available balance
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("最大保证金")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("0.000 BTC")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Spacer()
                        Text("0 USDT")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                // Buy button
                Button(action: {}) {
                    Text("买入/做多")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                
                // Sell button
                Button(action: {}) {
                    Text("卖出/做空")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background(Color.white)
    }
    
    private var welcomeBannerView: some View {
        HStack {
            Image(systemName: "gift.fill")
                .font(.system(size: 20))
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("欢迎")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                Text("马上开户，开启您的合约交易")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("领取")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.yellow)
                    .cornerRadius(16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.yellow.opacity(0.3))
    }
    
    private var bottomSectionView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("持有仓位 (0)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("当前委托 (0)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text("合约网格")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            
            VStack(spacing: 40) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                
                Text("暂无合位")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
            .padding(.vertical, 60)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

struct FuturesOrderItem {
    let price: String
    let quantity: String
    let isCurrent: Bool
    
    init(price: String, quantity: String, isCurrent: Bool = false) {
        self.price = price
        self.quantity = quantity
        self.isCurrent = isCurrent
    }
}

#Preview {
    FuturesView()
}
