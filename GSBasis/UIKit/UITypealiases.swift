//
//  UITypealiases.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/13.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit

    public typealias GSView = UIView
    public typealias GSTableView = UITableView
    public typealias GSTableViewCell = UITableViewCell
    public typealias GSCollectionViewCell = UICollectionViewCell
    public typealias GSTableViewHeaderFooterView = UITableViewHeaderFooterView
    public typealias GSCollectionReusableView = UICollectionReusableView
    public typealias GSFont = UIFont
    public typealias GSResponder = UIResponder


#else
    import AppKit

    public typealias GSView = NSView
    public typealias GSFont = NSFont
    public typealias GSResponder = NSResponder
#endif
