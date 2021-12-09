//
//  VideoView.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 09.12.2021.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    
    // MARK: - UI elements
    lazy var button = createButton()
    
    // MARK: - State change
    var url: URL? {
        didSet {
          createPlayer(with: url)
        }
    }
    var isPlayed = false {
        didSet {
            switch isPlayed {
            case true:
                player.play()
                button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            case false:
                player.pause()
                button.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    // MARK: - Player
    var player: AVPlayer!

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addButton()
    }
    
    
    // MARK: - Add UI elements
    private func addButton() {
        addSubview(button)
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            .isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            .isActive = true
    }
    
}
// MARK: - Additional methods
extension VideoView {
    @objc func changeState() {
        isPlayed.toggle()
    }
    
    private func createButton() -> UIButton {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = .red
        configuration.image = UIImage(systemName: "play.fill")
        
        b.configuration = configuration
        b.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        b.isEnabled = false
        return b
    }
    
    private func createPlayer(with url: URL?) {
        guard let url = url else { return }

        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.addSublayer(button.layer)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        
        if self.layer.sublayers?.count != 1 {
            self.layer.sublayers?.removeFirst()
        }
        button.isEnabled = true
    }
}

