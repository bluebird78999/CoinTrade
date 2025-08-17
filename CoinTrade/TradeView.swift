//
//  TradeView.swift
//  CoinTrade
//
//  Created by LiuHongfeng on 2025/8/17.
//

import SwiftUI

struct TradeView: View {
    @State private var selectedTab = 0
    @State private var selectedOrderType = 0
    @State private var priceText = "118062.90"
    @State private var quantityText = ""
    @State private var totalText = ""
    @State private var stopLoss = false
    @State private var icebergOrder = false
    
    let tabs = ["闪兑", "现货", "杠杆", "C2C"]
    let orderTypes = ["限价单", "市价单"]
    
    let orderBookData = [
        OrderBookItem(price: "118,064.00", quantity: "0.03185", side: .sell),
        OrderBookItem(price: "118,063.99", quantity: "0.00010", side: .sell),
        OrderBookItem(price: "118,063.84", quantity: "0.01721", side: .sell),
        OrderBookItem(price: "118,063.83", quantity: "0.00010", side: .sell),
        OrderBookItem(price: "118,063.68", quantity: "0.00138", side: .sell),
        OrderBookItem(price: "118,062.91", quantity: "0.00055", side: .sell),
        OrderBookItem(price: "118,062.90", quantity: "4.77436", side: .current),
        OrderBookItem(price: "118,062.89", quantity: "3.94376", side: .buy),
        OrderBookItem(price: "118,062.88", quantity: "0.00040", side: .buy),
        OrderBookItem(price: "118,062.01", quantity: "0.00010", side: .buy),
        OrderBookItem(price: "118,062.00", quantity: "0.03195", side: .buy),
        OrderBookItem(price: "118,061.84", quantity: "0.00005", side: .buy),
        OrderBookItem(price: "118,060.66", quantity: "0.00016", side: .buy),
        OrderBookItem(price: "118,060.65", quantity: "0.00015", side: .buy)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Header with safe area
                headerView
                    .padding(.top, geometry.safeAreaInsets.top)
                
                // Trading pair info
                tradingPairView
                
                ScrollView {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            // Order book
                            orderBookView
                                .frame(maxWidth: .infinity)
                            
                            // Trading panel
                            tradingPanelView
                                .frame(maxWidth: .infinity)
                        }
                        .frame(minHeight: 400)
                        
                        // Bottom section
                        bottomSectionView
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            .ignoresSafeArea(.all, edges: .top)
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 20) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: { selectedTab = index }) {
                    Text(tabs[index])
                        .font(.system(size: 16, weight: selectedTab == index ? .medium : .regular))
                        .foregroundColor(selectedTab == index ? .black : .gray)
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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("BTC/USDT")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                Text("+0.52%")
                    .font(.system(size: 14))
                    .foregroundColor(.green)
            }
            
            Spacer()
            
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
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    private var orderBookView: some View {
        VStack(spacing: 0) {
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
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemGray6))
            
            // Order book items
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(orderBookData, id: \.price) { item in
                        orderBookRow(item: item)
                    }
                }
            }
            .frame(maxHeight: 300)
            
            // Depth selector
            HStack {
                Text("0.01")
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
    
    private func orderBookRow(item: OrderBookItem) -> some View {
        HStack {
            Text(item.price)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(item.side == .current ? .white : 
                               item.side == .buy ? .green : .red)
            
            Spacer()
            
            Text(item.quantity)
                .font(.system(size: 12))
                .foregroundColor(item.side == .current ? .white : .black)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
        .background(item.side == .current ? Color.gray : 
                   item.side == .buy ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
    }
    
    private var tradingPanelView: some View {
        VStack(spacing: 0) {
            // Buy/Sell toggle
            HStack(spacing: 0) {
                Button(action: {}) {
                    Text("买入")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.green)
                }
                
                Button(action: {}) {
                    Text("卖出")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color(UIColor.systemGray6))
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
                    
                    TextField("118062.90", text: $priceText)
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
                
                // Total amount
                VStack(alignment: .leading, spacing: 4) {
                    Text("成交金额 (USDT)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    TextField("", text: $totalText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Options
                VStack(spacing: 8) {
                    HStack {
                        Button(action: { stopLoss.toggle() }) {
                            HStack {
                                Image(systemName: stopLoss ? "checkmark.square" : "square")
                                    .foregroundColor(.gray)
                                Text("止盈/止损")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: { icebergOrder.toggle() }) {
                            HStack {
                                Image(systemName: icebergOrder ? "checkmark.square" : "square")
                                    .foregroundColor(.gray)
                                Text("冰山单")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                }
                
                // Available balance
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("可用")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("0 USDT")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.yellow)
                    }
                    
                    HStack {
                        Text("可买")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("0 BTC")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("预估手续费")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("-- BTC")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                // Buy button
                Button(action: {}) {
                    Text("买入 BTC")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background(Color.white)
    }
    
    private var bottomSectionView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("当前委托 (0)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("持有币种 (2)")
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
                
                VStack(spacing: 8) {
                    Text("可用余额：0.00 USDT")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("将资金转入您的现货钱包进行交易")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("增加余额")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.yellow)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

struct OrderBookItem {
    let price: String
    let quantity: String
    let side: OrderSide
}

enum OrderSide {
    case buy, sell, current
}

#Preview {
    TradeView()
}
