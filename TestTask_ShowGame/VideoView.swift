//
//  VideoView.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import UIKit

class VideoView: UIView {
    // MARK: - UI elements
    lazy var button = createButton()
    

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addButton()
    }
    
    private func addButton() {
        addSubview(button)
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            .isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            .isActive = true
    }
}
extension VideoView {
    func createButton() -> UIButton {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "play.fill"), for: .normal)
        b.tintColor = .black
        return b
    }
}

