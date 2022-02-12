//
//  ScrollViewOffsetPreferenceKey.swift
//  ScrollView_offset_tutorial
//
//  Created by Jeff Jeong on 2022/02/12.
//

import Foundation
import SwiftUI

/// 스크롤뷰 옵셋 프레퍼런스키
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


extension View {
    
    /// 스크롤뷰 바텀 여부
    /// - Parameters:
    ///   - threshold: 여유수치
    ///   - action: 바텀 여부 액션
    /// - Returns:
    func isScrollViewBottom(threshold: CGFloat = 0, action: @escaping (_ isBottom: Bool) -> ()) -> some View {
        self.background(GeometryReader{ proxy in
            Text("")
                .preference(key: ScrollViewOffsetPreferenceKey.self, value: proxy.frame(in: .global).minY)
        })
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { updatedOffset in
//            print("ContentView - updatedOffset: ", updatedOffset)
            let isBottom = (updatedOffset - threshold) < UIScreen.main.bounds.height
//            print("ContentView - isBottom: ", isBottom)
            action(isBottom)
        })
    }
}
