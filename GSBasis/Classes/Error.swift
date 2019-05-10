//
//  Error.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/10.
//

import Foundation

/// A type that describe an error's reason
public protocol ErrorReason {
    
    /// error reason debug description, '' by default
    var localizedDescription: String { get }
}

extension ErrorReason { var localizedDescription: String { return "" } }

/// A type that error returned by something. It encompasses a few different types of errors, each with their own associated reasons.
///
/// For example:
///
///     enum APIError: Error {
///
///         enum NetworkWrongReason {
///             case noNetwork
///             case timeout
///         }
///
///         enum ServerWrongReason {
///             case noResponse
///             case stateWrong(stateCode: Int)
///             case apiWrong(apiCode: Int)
///         }
///
///         case networkWrong(reason: NetworkWrongReason)
///         case serverWrong(reason: ServerWrongReason)
///     }
public protocol GSError: LocalizedError {}
