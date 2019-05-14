//
//  UICompatible.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/13.
//

import SnapKit

// MARK: - Compatible for UIResponder

extension GSResponder: Compatible {}

// MARK: - UIView

extension GS where Base: GSView {

    /// Tool method for 'addSubview()' and 'makeConstraints()'
    ///
    /// - Parameters:
    ///   - view: The view which need add to base
    ///   - closure: The constraint for view
    public func addSubvie(_ view: GSView, _ closure: ((ConstraintMaker) -> Void)? = nil) {
        guard view.superview != base else { return }
        view.removeFromSuperview()
        base.addSubview(view)
        guard let closure = closure else { return }
        view.snp.makeConstraints(closure)
    }
    
    /// Tool method for delete subview with given condition closure
    ///
    /// - Parameter closure: whether delete the view or not's closure
    public func removeSubviews(_ closure: ((GSView) -> Bool)? = nil) { base.subviews.forEach { if closure?($0) ?? true { $0.removeFromSuperview() } } }
    
}

#if os(iOS) || os(tvOS)

extension GS where Base: UIButton {
    
    public enum ButtonImagePosition: Int {
        case left, right, top, bottom
    }
    
    
    public func update(imagePosition position: ButtonImagePosition = .left, padding: CGFloat) {
        
        let imageWidth = base.imageView?.image?.size.width ?? 0
        let imageHeight = base.imageView?.image?.size.height ?? 0
        let font: UIFont = base.titleLabel?.font ?? GSFont.systemFont(ofSize: 14)
        base.titleLabel?.font = font
        
        let labelSize = base.currentTitle?.size(withAttributes: [.font: font]) ?? CGSize(width: 0, height: 0)
        let labelWidth = labelSize.width
        let labelHeight = labelSize.height
        let halfSpacing = padding * 0.5
        let imageOffsetX = (imageWidth + labelWidth) * 0.5 - imageWidth * 0.5
        let imageOffsetY = imageHeight * 0.5 + halfSpacing
        let labelOffsetX = (imageWidth + labelWidth * 0.5) - (imageWidth + labelWidth) * 0.5
        let labelOffsetY = labelHeight * 0.5 + halfSpacing
        let tempWidth = max(labelWidth, imageWidth)
        let changeWidth = labelWidth + imageWidth - tempWidth
        let tempHeight = max(labelHeight, imageHeight)
        let changedHeight = labelHeight + imageHeight + padding - tempHeight
        let halfChangedWidth = changeWidth * 0.5
        
        var imageEdgeInsets = UIEdgeInsets.init()
        var titleEdgeInsets = GSEdgeInsets.init()
        var contentEdgeInsets = GSEdgeInsets.init()
        var touchEdgeInsets = GSEdgeInsets.init()
        switch position {
        case .left:
            imageEdgeInsets = GSEdgeInsets.init(top: 0, left: -halfSpacing, bottom: 0, right: halfSpacing)
            titleEdgeInsets = GSEdgeInsets.init(top: 0, left: halfSpacing, bottom: 0, right: -halfSpacing)
            contentEdgeInsets = GSEdgeInsets.init(top: 0, left: halfSpacing, bottom: 0, right: halfSpacing)
            touchEdgeInsets = GSEdgeInsets.init(top: 0, left: -halfSpacing, bottom: 0, right: -halfSpacing)
        case .right:
            imageEdgeInsets = GSEdgeInsets.init(top: 0, left: labelWidth + halfSpacing, bottom: 0, right: -(labelWidth + halfSpacing))
            titleEdgeInsets = GSEdgeInsets.init(top: 0, left: -(imageWidth + halfSpacing), bottom: 0, right: imageWidth + halfSpacing)
            contentEdgeInsets = GSEdgeInsets.init(top: 0, left: halfSpacing, bottom: 0, right: halfSpacing)
            touchEdgeInsets = GSEdgeInsets.init(top: 0, left: -halfSpacing, bottom: 0, right: -halfSpacing)
        case .top:
            imageEdgeInsets = GSEdgeInsets.init(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            titleEdgeInsets = GSEdgeInsets.init(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            contentEdgeInsets = GSEdgeInsets.init(top: imageOffsetY, left: -halfChangedWidth, bottom: changedHeight - imageOffsetY, right: -halfChangedWidth)
            touchEdgeInsets = GSEdgeInsets.init(top: -imageOffsetY, left: -halfChangedWidth, bottom: -(changedHeight - imageOffsetY), right: -halfChangedWidth)
        case .bottom:
            imageEdgeInsets = GSEdgeInsets.init(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            titleEdgeInsets = GSEdgeInsets.init(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
            contentEdgeInsets = GSEdgeInsets.init(top: changedHeight - imageOffsetY, left: -halfChangedWidth, bottom: imageOffsetY, right: -halfChangedWidth)
            touchEdgeInsets = GSEdgeInsets.init(top: -(changedHeight - imageOffsetY), left: -halfChangedWidth, bottom: -imageOffsetY, right: -halfChangedWidth)
        }
        
        base.imageEdgeInsets = imageEdgeInsets
        base.titleEdgeInsets = titleEdgeInsets
        base.contentEdgeInsets = contentEdgeInsets
        base.touchEdgeInset = touchEdgeInsets
    }
}

// MARK: - UIViewController

extension GS where Base: UIViewController {
    
    /// Tool method like UIViewController.push
    ///
    /// - Note: If current doesn't in a navigationController's stack, will use 'present(viewController:animated:completion:)'
    /// - Note: Will check viewController's type class is already in stack or not, in order to prevent repeated stacking
    ///
    /// - Parameters:
    ///   - viewController: ViewController which will need show
    ///   - force: force or not, mean will show controller whatever or not with a controller's type class is already in stack
    public func push(viewController: UIViewController?, animated: Bool = true, completion: ((Bool) -> Void)? = nil, force: Bool = false ) {
        if let controller = viewController {
            if let navigationController = (base as? UINavigationController) ?? (base.navigationController) {
                if (navigationController.topViewController?.isKind(of: controller.classForCoder) ?? false) && !force { return }
                #if os(iOS)
                    navigationController.pushViewController(controller.then { $0.hidesBottomBarWhenPushed = true }, animated: animated)
                #else
                    navigationController.pushViewController(controller, animated: animated)
                #endif
                
                
                completion?(true)
            } else { present(viewController: controller, animated: true, completion: completion)}
        } else { completion?(false) }
    }
    
    /// Tool method like UIViewController.present
    ///
    /// - Parameters:
    ///   - viewController: ViewController which will need show
    public func present(viewController: UIViewController?, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let controller = viewController { base.present(controller, animated: animated) { completion?(true) } }
        else { completion?(false) }
    }
    
    /// Tool method like UIViewController.popViewController
    ///
    /// - Note: If current doesn't in a navigationController's stack, will use 'dismiss(animated:completion:)'
    public func popSelf(animated: Bool) {
        guard let navigationController = base.navigationController else { return  dismiss(animated: animated) }
        navigationController.popViewController(animated: animated)
    }
    
    /// Tool method like UIViewController.dismiss
    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        base.dismiss(animated: animated, completion: completion)
    }
    
    /// Tool method like UIViewController.popToRoot
    public func popToRoot() {
        guard let navigationController = base.navigationController else { return  dismiss(animated: true) }
        navigationController.popToRootViewController(animated: true)
    }
    
    /// Tool method like UIViewController.popTo(:)
    ///
    /// - Parameters:
    ///   - vc: A controller's type class
    ///   - orPopToRoot: If not found the controller's type, will pop to root or just previous controller,
    public func popTo(_ vc: UIViewController.Type, _ orPopToRoot: Bool = true) {
        guard let navigationController = base.navigationController else { return popToRoot() }
        let list = navigationController.viewControllers.reversed().filter { return $0.isKind(of: vc) }
        guard let c = list.first else {
            if orPopToRoot { self.popToRoot() }
            else { self.popSelf(animated: true) }
            return
        }
        
        navigationController.popToViewController(c, animated: true)
    }
}

#endif
