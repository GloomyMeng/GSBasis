//
//  Notifier.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/10.
//

import Foundation

// MARK: - Compatible

extension NotificationCenter: Compatible {}

// MARK: NotificationCenter

extension GS where Base: NotificationCenter {
    
    /// Convenience for 'addObserver(forName:object:queue:using:)'
    ///
    /// Use to add observer for a Notification.Name callback by a closure and doesn't need to run 'removeObserver(_:)' when deinit
    ///
    /// For example:
    ///
    ///     NotificationCenter.default.gs.addObserver(self, name: Notification.Name.gs.TableView.finishPull, object: nil) { (target, noti) in
    ///         target?.//do something
    ///     }
    ///
    /// - Parameters:
    ///   - observer: the receiver of notification. in closure, observer is weak reference
    ///   - name: the name of the notification for which to register the observer; that is, only notifications with this name are used to add the block to the operation queue.
    ///   - anObject: the object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
    ///   - queue: the operation queue to which block should be added. If you pass nil, the block is run synchronously on the posting thread.
    ///   - handler: The block to be executed when the notification is received. The block is copied by the notification center and (the copy) held until the observer registration is removed
    /// - Returns: the object which is 'true' observer for NotificationCenter
    @discardableResult
    public func addObserver<T: AnyObject>(_ observer: T, name: Notification.Name, object anObject: Any?, queue: OperationQueue? = OperationQueue.main, handler: @escaping (_ observer: T?, _ notification: Notification) -> Void) -> AnyObject {
        let observation = base.addObserver(forName: name, object: anObject, queue: queue) { [weak observer] noti in handler(observer, noti) }
        GSObserveationRemover.init(observation).makeRetainBy(observer)
        return observation
    }
}

private class GSObserveationRemover: NSObject {
    
    let observation: NSObjectProtocol
    
    init(_ obs: NSObjectProtocol) { observation = obs; super.init() }
    deinit { NotificationCenter.default.removeObserver(observation) }
    
    func makeRetainBy(_ owner: AnyObject) { GS_observationRemoversForObject(owner).add(self) }
}

private var kGSObservationRemoversForObject = "\(#file)+\(#line)"
private func GS_observationRemoversForObject(_ object: AnyObject) -> NSMutableArray {
    return objc_getAssociatedObject(object, &kGSObservationRemoversForObject) as? NSMutableArray ?? NSMutableArray.init().then {
        objc_setAssociatedObject(object, &kGSObservationRemoversForObject, $0, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

// MARK: - Notifier

/// Protocol 'NotifierType' use for handle Notification
/// For example:
///
///     enum UserStatusNotifier: String, NotifierType {
///         case login
///         case logout
///         .....
///     }
///
/// And a controller want to handl user logout notification, just add this:
///
///     UserStatusNotifier.login.addObserver(self, object: nil) { (controller, notification) in
///         .....
///     }
///
/// - Doesn't need to 'removeObserver'.
/// - Default prefix is 'Bundle.main.bundleIdentifier'
///
public protocol NotifierType {
    var prefix: String { get }
}

public extension NotifierType { var prefix: String { return Bundle.identifier } }

extension RawRepresentable where Self: NotifierType, Self.RawValue == String {
    
    var notificationName: Notification.Name { return Notification.Name.init(self.prefix + self.rawValue) }
    
    public func addObserver<T: AnyObject>(_ observer: T, queue: OperationQueue? = OperationQueue.main, object obj: AnyObject?, handler: @escaping (_ observer: T?, _ notification: Notification) -> Void) {
        NotificationCenter.default.gs.addObserver(observer, name: notificationName, object: obj, queue: queue, handler: handler)
    }
}
