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
    
    var url: URL? {
        didSet {
          createPlayer(with: url)
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addButton()
    }
    
    @objc func changeState() {
        print("state changed")
    }
    
    private func addButton() {
        addSubview(button)
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            .isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            .isActive = true
    }
    private func createPlayer(with url: URL?) {
        guard let url = url else { return }

        //2. Create AVPlayer object
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        //3. Create AVPlayerLayer object
        let playerLayer = AVPlayerLayer(player: player)
        let videoViewFrame = self.bounds
        playerLayer.frame = videoViewFrame
        playerLayer.videoGravity = .resizeAspect
        
        //4. Add playerLayer to view's layer
        //view?.addLayer(playerLayer)
        self.layer.addSublayer(playerLayer)
        //5. Play Video
        player.play()
        
    }
}
extension VideoView {
    func createButton() -> UIButton {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "play.fill"), for: .normal)
        b.tintColor = .black
        b.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        return b
    }
}

