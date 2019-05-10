//
//  Extensions.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/10.
//

import Foundation

/// Convenience for 'fatalError()' with a default value, to use in DEBUG or not
public func _fatailError<T>(_ msg: String = "Got some error, because can't go there in normal", value: @autoclosure () throws -> T) rethrows -> T {
    #if DEBUG
    fatalError(msg)
    #else
    return try value()
    #endif
}

// MARK: - Array

public extension Array {
    
    /// Safely to get object from an array. if index < 0 or index > array.count, will return nil
    ///
    /// - Parameter index: the index of object needed
    subscript(gs index: Int) -> Element? {
        guard index >= 0 else { return nil }
        return count > index ? self[index] : nil
    }
    
    /// Safely to get object from an array. if range out of bounds, will return empty array
    ///
    /// - Parameter bounds: the range of objects needed
    subscript(gs bounds: Range<Int>) -> ArraySlice<Element> {
        return bounds.lowerBound > -1 && bounds.upperBound < count && bounds.lowerBound <= bounds.upperBound ? self[bounds] : []
    }
}


// MARK: - Bundle

public extension Bundle {
    
    /// A value of app packaging environment
    ///
    /// All values:
    ///
    ///     Beta(if is DEBUG)
    ///     In-House
    ///     AppStore
    static var appChannel: String {
        #if DEBUG
        return "Beta"
        #else
        return isInHouse ? "In-House" : "AppStore"
        #endif
    }
    
    /// A value of app version. 'CFBundleShortVersionString' in plist file. "" by default
    static var shortVersion: String { return main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
    
    /// A value of app build version. 'kCFBundleVersionKey' in plist file. "" by default
    static var buildVersion: String { return main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? "" }
    
    /// A value of app bundleIdentifier. "" by default
    static var identifier: String { return main.bundleIdentifier ?? "" }
    
    /// A value for app is in-house version
    static var isInHouse: Bool {
        return main.bundleIdentifier?.contains("inhouse") ?? false
    }
    
    /// A value of app display name. 'CFBundleDisplayName' in plist file. "" by default
    static var displayName: String {
        return "\(main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? "")"
    }
}

// MARK: - DispatchQueue

//public extension DispatchQueue {
//    
//    private static var _onceTracker = [String]()
//    
//    /// Run once only in current thread whit simple tokne
//    ///
//    /// - Parameters:
//    ///   - token: simple token
//    ///   - block: run closur
//    static func once(token: String, block: ()-> Void) {
//        objc_sync_enter(self)
//        defer {
//            objc_sync_exit(self)
//        }
//        
//        guard !_onceTracker.contains(token) else {
//            return
//        }
//        
//        _onceTracker.append(token)
//        block()
//    }
//}

// MARK: - Data

extension Data {
    
    /// Transform data to string with utf8, nil by default
    public func toString() -> String? { return String.init(data: self, encoding: .utf8) }
}

// MARK: - Date

extension Date {
    
    /// Transform data to string with utf8, nil by default
    public static var millisecond: Int64 { return Int64.init(Date.init().timeIntervalSince1970 * 1000) }
}
