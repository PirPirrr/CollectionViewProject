//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class ViewController: UICollectionViewController {
    enum Section {
        case main
        case favs
    }
    
    enum Item: Hashable {
        case favLandmark(Landmark)
        case mainLandmark(Landmark)
    }
    
    var landmarks: [Landmark] = []
    var favLandmarks: [Landmark] = []
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Load JSON
        do {
            let jsonData: Data = readLocalFile(forName: "landmarkData")!
            landmarks = try JSONDecoder().decode([Landmark].self, from: jsonData)
        } catch {
            print(error)
        }
        
        //load fav
        for landmark in landmarks {
            if landmark.isFavorite{
                favLandmarks.append(landmark)
            }
        }
        
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderCollectionReusableView")
        
        configureDataSource()
        collectionView.collectionViewLayout = createLayout()
        loadInitialState(landmarks: self.landmarks)
       
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func configureDataSource(){
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier{
            case .favLandmark:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! LandmarkFavItemCell
                cell.favLandmarkImage.image = self.favLandmarks[indexPath.item].image
                return cell
            case .mainLandmark:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! LandmarkItemCell
                cell.nameLandmark.text = self.landmarks[indexPath.item].name
                cell.imageLandmark.image = self.landmarks[indexPath.item].image
                switch self.landmarks[indexPath.item].category{
                case .lakes:
                    cell.emoji.text = "🌊"
                case .moutains:
                    cell.emoji.text = "⛰️"
                case .rivers:
                    cell.emoji.text = "🏞️"
                }
                return cell
            }
        })
        
        diffableDataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            switch elementKind{
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath)
                return header
            default:
                return nil
            }
        }
    }
    

    
    private func createSnapshot(landmarks: [Landmark]) -> NSDiffableDataSourceSnapshot<Section,Item>{
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([.favs, .main])
        
        let items = favLandmarks.map { Item.favLandmark($0)}
        snapshot.appendItems(items, toSection: .favs)
        
        let items2 = landmarks.map{Item.mainLandmark($0)}
        snapshot.appendItems(items2, toSection: .main)
        return snapshot
    }
    
    private func loadInitialState(landmarks: [Landmark]){
        let snapshot = createSnapshot(landmarks: landmarks)
        diffableDataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, collectionLayoutEnvironment in
            guard let self = self,
                  let section = self.diffableDataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            switch section {
            case .favs:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.25))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                section.interGroupSpacing = 8
                return section
            }
        }
        return layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "detail":
            (segue.destination as! DetailLandmarkViewController).landmark = landmarks[collectionView.indexPath(for: sender as! UICollectionViewCell)?.item ?? 0]
            segue.destination.title = landmarks[collectionView.indexPath(for: sender as! UICollectionViewCell)?.item ?? 0].name
        default:
            break
        }
    }
    
    
}





