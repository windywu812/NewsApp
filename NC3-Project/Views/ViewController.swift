//
//  ViewController.swift
//  NC3-Project
//
//  Created by Windy on 29/08/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Article>?
    var collectionView: UICollectionView!
    
    var viewModel = ArticleViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
        bindViewModel()
    }
    
    
    private func bindViewModel() {
        viewModel.$highlightToken.sink { (articles) in
            self.viewModel.headline = articles
            self.applySnapshot()
        }.store(in: &cancellables)
        
        viewModel.$businessToken.sink { (articles) in
            self.viewModel.business = articles
            self.applySnapshot()
        }.store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Indo News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.register(LargeCell.self, forCellWithReuseIdentifier: LargeCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        configureDataSource()
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.topHeadline, .business, .technology, .science])
        
        let headline = viewModel.headline
        let business = viewModel.business
        
        snapshot.appendItems(headline, toSection: .topHeadline)
        snapshot.appendItems(business, toSection: .business)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexpath, article) -> UICollectionViewCell? in
            switch indexpath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCell.reuseIdentifier, for: indexpath) as! LargeCell
                cell.article = article
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCell.reuseIdentifier, for: indexpath) as! LargeCell
                cell.article = article
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCell.reuseIdentifier, for: indexpath) as! LargeCell
                cell.article = article
                return cell
            default:
                return nil
            }
            
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
            
            switch indexPath.section {
            case 0:
                sectionHeader.title.text = Section.topHeadline.string
            case 1:
                sectionHeader.title.text = Section.business.string
            case 2:
                sectionHeader.title.text = Section.technology.string
            default:
                break
            }
            
            return sectionHeader
        }

    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(250)), subitems: [layoutItem])
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
                
                layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
                
                return layoutSection
            case 1:
                let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10)
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(200)), subitems: [layoutItem])
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
                
                layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
                
                return layoutSection
            default:
                let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10)
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(200)), subitems: [layoutItem])
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
                
                layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
                
                return layoutSection
            }
        }
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
          let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 20)
          return layoutSectionHeader
      }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print(viewModel.highlightToken[indexPath.row].title)
        default:
            print(viewModel.businessToken[indexPath.row].title)
        }
    }
    
}
