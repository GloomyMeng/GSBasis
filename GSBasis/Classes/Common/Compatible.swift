//
//  Compatible.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/10.
//

import Foundation

extension Compatible {
    public var gs: GS<Self> { get { return GS(self) } }
}

/// extension Use 'GS' to manager instance methods
/// For example:
///
///     extension String: Compatible {}
///
///     extension GS where Base == String {
///
///         /// String's length
///         public var length: Int {
///             return base.characters.count
///         }
///     }
public protocol Compatible {
    
    associatedtype CompatibleType
    var gs: CompatibleType { get }
}

public final class GS<Base> {
    
    /// wrapped instance object
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
