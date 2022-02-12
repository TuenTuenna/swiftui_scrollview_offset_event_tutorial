//
//  ScrollViewHelper.swift
//  ScrollView_offset_tutorial
//
//  Created by Jeff Jeong on 2022/02/12.
//

import Foundation
import UIKit
import Combine


/// 스크롤뷰 핼퍼
class ScrollViewHelper : NSObject, UIScrollViewDelegate, ObservableObject {
    
    @Published var isBottomValue : Bool = false
    
    let threshold : CGFloat
    
//    lazy var isBottom : AnyPublisher<Bool, Never> = $isBottomValue.removeDuplicates().eraseToAnyPublisher()
    
    lazy var isBottom : AnyPublisher<Bool, Never> = $isBottomValue.eraseToAnyPublisher()
    
    init(threshold : CGFloat = 0){
        self.threshold = threshold
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("ScrollViewHelper scrollViewDidScroll() called / scrollView.contentOffset.y: \(scrollView.contentOffset.y)")
    
        self.isBottomValue = isScrollBottom(scrollView)
        print("isScrollBottom(scrollView) : ", isScrollBottom(scrollView))
    }
    
    fileprivate func isScrollBottom(_ scrollView : UIScrollView) -> Bool {
        return scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < threshold
    }
    
}
