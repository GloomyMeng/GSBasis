//
//  TemplateClass.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/13.
//

/// A view extension `UIView` and `ViewAssemble`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class AView: ViewAssmbled {
///
///         override func assembling(_ rect: CGRect) {
///             self.do {
///                 $0.gs.add(UIView.init().then {
///                     $0.backgroundColor = UIColor.red
///                     $0.layer.borderColor = UIColor.green.cgColor
///                     $0.layer.borderWidth = 1
///                 }) {
///                     $0.center.equalToSuperview()
///                     $0.width.height.equalTo(rect.size).multipliedBy(0.5)
///                 }
///             }
///         }
///     }
open class ViewAssmbled: GSView, ViewAssemble {
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    public init() { super.init(frame: CGRect.zero); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

/// A view extension `ViewAssmbled` and `ViewIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class BView: ViewIndie<DataModel> {
///
///         var label = UILabel.init()
///
///         override var model: DataModel? {
///             didSet {
///                 label.text = model?.name
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
///             self.do {
///                 $0.gs.add(label.then {
///                     $0.font = UIFont.systemFont(ofSize: 12)
///                 }) {
///                     $0.center.equalToSuperview()
///                     $0.width.height.equalTo(rect.size).multipliedBy(0.5)
///                 }
///             }
///         }
///     }
open class ViewIndie<T>: ViewAssmbled, ViewIndieable {
    
    open var model: T?
}

#if os(iOS) || os(tvOS)

/// A Cell extension `UITableViewCell` and `CellIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class TableViewCell: TableViewCellIndie<DataModel> {
///
///         var identifier: String { return "lalala" }
///
///         override var model: DataModel? {
///             didSet {
///
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
///             // do something
///         }
///
///         static func sizeForCell(model: DataModel?) -> CGSize {
///             return CGSize.zero
///         }
///     }
open class TableViewCellIndie<T>: GSTableViewCell, CellIndieable {
    
    open var model: T?
    
    public override init(style: GSTableViewCell.CellStyle, reuseIdentifier: String?) { super.init(style: style, reuseIdentifier: reuseIdentifier); assembling(CGRect.zero) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

/// A Cell extension `UICollectionViewCell` and `CellIndieable`. must override `assembling(_ rect: CGRect)`
///
/// Like:
///
///     class CollectionViewCell: CollectionViewCell<DataModel> {
///
///         var identifier: String { return "lalala" }
///
///         override var model: DataModel? {
///             didSet {
///
///             }
///         }
///
///         override func assembling(_ rect: CGRect) {
///             // do something
///         }
///
///         static func sizeForCell(model: DataModel?) -> CGSize {
///             return CGSize.zero
///         }
///     }
open class CollectionViewCell<T>: GSCollectionViewCell, CellIndieable {
    
    open var model: T?
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

open class TableViewHeaderFooterView<T>: GSTableViewHeaderFooterView, CellIndieable {
    open var model: T?
    
    public override init(reuseIdentifier: String?) { super.init(reuseIdentifier: reuseIdentifier); assembling(frame) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

open class CollectionReusableView<T>: GSCollectionReusableView, CellIndieable {
    open var model: T?
    
    public override init(frame: CGRect) { super.init(frame: frame); assembling(frame) }
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); assembling(CGRect.zero) }
    
    open func assembling(_ rect: CGRect) { _fatailError(" Must Need Override 'assembling(_ rect: CGRect)' ", value: ()) }
}

#endif
