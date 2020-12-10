import Foundation
import UIKit
import SnapKit

open class BaseView: UIView {

    required public init() {
        super.init(frame: CGRect.zero)
        
        setupSubviews()
        addSubviews()
        setupAutoLayout()
        setupColorsAndStyles()
        bindUI()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("You should not be using Interface builder ;)")
    }

    open func setupSubviews() {}

    open func addSubviews() {}

    open func setupAutoLayout() {}

    open func bindUI() {}

    open func setupColorsAndStyles() {}
}
