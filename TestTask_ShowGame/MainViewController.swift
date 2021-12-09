//
//  ViewController.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import UIKit
import AVFoundation

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    // MARK: - UI elements
    lazy var tournamentNameLabel = createLabel()
    lazy var gameDateLabel = createLabel()
    lazy var firstTeamNameLabel = createLabel()
    lazy var firstTeamScoreLabel = createLabel()
    lazy var secondTeamNameLabel = createLabel()
    lazy var secondTeamScoreLabel = createLabel()
    
    lazy var collectionView = createCollectionView()
    
    lazy var videoView = createVideoView()
    
    lazy var firstHorizStackView = createStackView(axis: .horizontal)
    lazy var secondHorizStackView = createStackView(axis: .horizontal)
    lazy var vertStackView = createStackView(axis: .vertical)
    
    
    let urlString = "https://cf-de28.instatfootball.tv/240/1724836_1.mp4?Expires=1638999247&Signature=AILCLgIL335WTPaqu71kfGV~qNRIcYpyBMd8VTo-l4~l07qnQ0N3PnlhYIrHwKynQv6rpK~BEKOoteuxhXovy~-M9knGemhYqqbazpON2MX13JOOEbq~GQW4LEn61HcuuTH~-mlVenxGr-wRO8F3ooLbnlW9Hdf0wJb6Srd-2MZC8ZONDg~FXFPNm6365hpBajps9xagenbRznglGLRFsyiXz-aYFnqwJ3TFjogLMTKOG77UBwfZmP2dqK6YP-U76tQTm5JOWYaRII6PWc28EzS4Nvo5WYRoA3O3AOOHINTpST5RRPcyRWD7OhzlwNQc43yqYGlYe5fki2VwA9dIw-KTAGtxaYWsG6IUFf88U2lF9UTMARvZkKMofZFqnjvn7fxZTFDvYi8ieva-HK5A~jjL53RtxbhtmDdo-037~H3Q4xc12qq0R~OaAAczvt18ySLFf2aU7-FuSwTgCHI-n1PO5OVir1wHELj1mMKv02cSo2JXGHKP0X~H2-~pDdvDXNSTJoIEB1hYbKw5FgS1Dsmfv5-OqNRBDtEW1JYvZTcpjC3kreabB29oOGjRFtKrJEjE5A1a7PQXBcXPcOxjzoAPPRUk1Ki1quoX2QyiPSa3OkLTFf0npNIDXs0al1xhJ9M4MuyHQpwmkFXWG3Rytq-7uz03i3fItsvgDM1HJzk_&Key-Pair-Id=APKAJP7V33NW3RCUW6CQ"
    
    var presenter: MainPresenterProtocol!
    
    let itemsPerColumn: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    override func viewDidLoad() {
        super.viewDidLoad()

        pinStackView()
        addLabelsToStackViews()
        pinVideoView()
        pinCollectionView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter.fetchGameInfo()
    }
    
    @IBAction func button() {
        if let url = URL(string: urlString) {
            //2. Create AVPlayer object
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            
            //3. Create AVPlayerLayer object
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.videoPlayerView.bounds //bounds of the view in which AVPlayer should be displayed
            playerLayer.videoGravity = .resizeAspect
            
            //4. Add playerLayer to view's layer
            self.videoPlayerView.layer.addSublayer(playerLayer)
            
            //5. Play Video
            player.play()
        }
    }
    // MARK: - Add UI elements
    private func addLabelsToStackViews() {
        firstHorizStackView.addArrangedSubview(firstTeamNameLabel)
        firstHorizStackView.addArrangedSubview(secondTeamNameLabel)
        firstHorizStackView.distribution = .fillProportionally
        firstHorizStackView.backgroundColor = .magenta
        
        secondHorizStackView.addArrangedSubview(firstTeamScoreLabel)
        secondHorizStackView.addArrangedSubview(secondTeamScoreLabel)
        secondHorizStackView.distribution = .fillEqually
        secondHorizStackView.backgroundColor = .purple
        
        vertStackView.addArrangedSubview(tournamentNameLabel)
        vertStackView.addArrangedSubview(gameDateLabel)
        vertStackView.addArrangedSubview(firstHorizStackView)
        vertStackView.addArrangedSubview(secondHorizStackView)
        
        vertStackView.distribution = .fillEqually
        vertStackView.backgroundColor = .lightGray
    }
    private func pinStackView() {
        view.addSubview(vertStackView)
        vertStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .isActive = true
        vertStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            .isActive = true
        vertStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        vertStackView.heightAnchor.constraint(equalToConstant: (view.frame.height/3))
            .isActive = true
    }
    private func pinVideoView() {
        view.addSubview(videoView)
        videoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            .isActive = true
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            .isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        videoView.heightAnchor.constraint(equalToConstant: (view.frame.height/3))
            .isActive = true
    }
    private func pinCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: vertStackView.bottomAnchor, constant: 20)
            .isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            .isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        collectionView.bottomAnchor.constraint(equalTo: videoView.topAnchor, constant: -20)
            .isActive = true
        
    }
}

extension MainViewController: MainViewProtocol {
    
}

