//
//  UIElementsFactory.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 10.12.2021.
//

import UIKit

enum FontName: String {
    case regular = "Menlo"
    case bold = "Menlo-Bold"
}

enum UIElementsFactory {
    static  func createLabel(fontName: FontName, fontSize: CGFloat) -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Foo"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: fontName.rawValue, size: fontSize)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }
    static func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }
    static func createVideoView() -> VideoView{
        let v = VideoView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return v
    }
    static func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = axis
        
        return sv
    }
}
