//
//  Extension + MainViewController.swift
//  TestTask_ShowGame
//
//  Created by Кирилл Нескоромный on 08.12.2021.
//

import UIKit

// MARK: - Collection View data source
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        presenter.videosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let videoData = presenter.getVideoData(at: indexPath)
        
        if let gamePeriod = videoData.period,
           let videoQuality = videoData.quality {
            cell.periodLabel.text = "Тайм: \(gamePeriod)"
            cell.qualityLabel.text = "Качество: \(videoQuality)"
        }
        
        return cell
    }
}
// MARK: - Collection View delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.preparePath(at: indexPath)  
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // находим размер ячейки в зависимости от размера экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingHeight = sectionInserts.left * (itemsPerColumn + 1)
        let availableHeight = collectionView.frame.height - paddingHeight
        let heightPerItem = availableHeight / itemsPerColumn
        return CGSize(width: heightPerItem * 2, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    // вертикальный отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    // горизонтальный отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}

