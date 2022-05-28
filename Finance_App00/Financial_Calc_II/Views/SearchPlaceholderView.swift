//
//  SearchPlaceholderView.swift
//  Financial_Calc_II
//
//  Created by a-robota on 5/22/22.
//

import UIKit

// MARK: searchView placeholder [for stock search]
class SearchPlaceholderView: UIView {

    
    private var imageView : UIImageView {
        let image = UIImage(named : "imDca")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "SearchHere"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)!
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("FatalError in NSCode")
    }

    private func setupViews() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 88) ])}
}





