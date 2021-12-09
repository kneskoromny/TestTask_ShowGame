//
//  ViewController.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import UIKit

// MARK: - Protocol requirements
protocol MainViewProtocol: AnyObject {
    func updateLabels()
    func updateCollectionView()
    
    func showVideo(from url: URL?)
}

class MainViewController: UIViewController {
    
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
    
    
    let itemsPerColumn: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        pinStackView()
        addLabelsToStackViews()
        pinVideoView()
        pinCollectionView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter.fetchGameStat()
        presenter.fetchGameVideos()
    }

    // MARK: - Add UI elements
    private func addLabelsToStackViews() {
        firstHorizStackView.addArrangedSubview(firstTeamNameLabel)
        firstHorizStackView.addArrangedSubview(secondTeamNameLabel)
        firstHorizStackView.distribution = .fillEqually
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
    // MARK: - Pin UI elements
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
// MARK: - Protocol requirements implementation
extension MainViewController: MainViewProtocol {
    func updateLabels() {
        guard let stat = presenter.stat else { return }
        
        tournamentNameLabel.text = stat.tournament?.nameRus
        gameDateLabel.text = stat.date
        firstTeamNameLabel.text = stat.team1?.nameRus
        if let firstTeamScore = stat.team1?.score {
            firstTeamScoreLabel.text = String(firstTeamScore)
        }
        secondTeamNameLabel.text = stat.team2?.nameRus
        if let secondTeamScore = stat.team2?.score {
            secondTeamScoreLabel.text = String(secondTeamScore)
        }
    }
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func showVideo(from url: URL?) {
        videoView.url = url
    }
}

