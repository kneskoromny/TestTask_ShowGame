//
//  CollectionCell.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    // MARK: - UI elements
    lazy var periodLabel = UIElementsFactory.createLabel(fontName: .bold, fontSize: 12)
    lazy var qualityLabel = UIElementsFactory.createLabel(fontName: .bold, fontSize: 12)
    
    lazy var stackView = UIElementsFactory.createStackView(axis: .vertical)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addLabelsToStackView()
        pinStackView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add UI elements
    private func addLabelsToStackView() {
        stackView.addArrangedSubview(periodLabel)
        stackView.addArrangedSubview(qualityLabel)
        
        stackView.distribution = .fillEqually
    }
    private func pinStackView() {
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor)
            .isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            .isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            .isActive = true
    }
}
