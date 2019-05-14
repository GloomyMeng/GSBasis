//
//  UIExtensions.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/13.
//

#if os(iOS) || os(tvOS)

// MARK: - UIControl

private var kGSTouchEdgeInset = "\(#file)+\(#line)"
extension UIControl {
    
    /// The offset in the click area for `UIControl`. to modify the click area. nil by default
    public var touchEdgeInset: UIEdgeInsets {
        get { return objc_getAssociatedObject(self, &kGSTouchEdgeInset) as? UIEdgeInsets ?? UIEdgeInsets.zero }
        set { objc_setAssociatedObject(self, &kGSTouchEdgeInset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if touchEdgeInset == UIEdgeInsets.zero || !isEnabled || !isUserInteractionEnabled || isHidden {
            return super.point(inside: point, with: event)
        }
        return bounds.inset(by: touchEdgeInset).contains(point)
    }
}

#endif
