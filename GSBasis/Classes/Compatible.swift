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

/// Extension Use 'GS' to manager instance methods
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

// MARK: DispatchQueue

extension DispatchQueue: Compatible {}
extension DispatchQueue { fileprivate static var _onceTracker = [String].init() }
extension GS where Base: DispatchQueue {
    
    /// Safely to use 'DispatchQueue.queue.async {}' on any queue, it can check whether is main queue
    /// If is in main queue, the closure will execute immediately, other will execute asynchronously
    ///
    /// - Parameter block: the closure whick need to run
    public func safeAsync(_ block: @escaping () -> Void) {
        if base === DispatchQueue.main && Thread.isMainThread { block() }
        else { base.async { block() } }
    }
    
    /// Convenience function to call 'dispatch_once' on the encapsulated closure.
    ///
    /// - Parameters:
    ///   - token: the tag marked as one for closure.
    ///   - block: the closure will run once
    static func once(token: String, block: ()-> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        guard Base._onceTracker.contains(token) else { return }
        Base._onceTracker.append(token)
        block()
    }
}

