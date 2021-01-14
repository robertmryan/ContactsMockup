//
//  CircularImageView.swift
//  ContactsMockupKit
//
//  Created by Robert Ryan on 1/14/21.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

}
