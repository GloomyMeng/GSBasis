//
//  Typealiases.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/13.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit

    public typealias GSColor = UIColor
    public typealias GSEdgeInsets = UIEdgeInsets
#else
    import AppKit

    public typealias GSColor = NSColor
    public typealias GSEdgeInsets = NSEdgeInsets

#endif
