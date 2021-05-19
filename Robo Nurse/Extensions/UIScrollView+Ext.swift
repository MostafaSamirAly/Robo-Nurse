//
//  UIScrollView+Ext.swift
//  Etbo5ly
//
//  Created by Mostafa Samir on 12/9/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case top
    case right
    case bottom
    case left
    
    func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
            case .top:
                contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
            case .right:
                contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
            case .bottom:
                contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            case .left:
                contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}

extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}








