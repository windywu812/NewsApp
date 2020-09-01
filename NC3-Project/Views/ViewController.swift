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
    
    var viewModel: ArticleViewModel!
    
    private var headLinesSubsription: Set<AnyCancellable> = []
    private var generalSubsription: Set<AnyCancellable> = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = ArticleViewModel()
        
        viewModel.$highlightArticles.sink { [weak self] articles in
            self?.applySnapshot(articles: articles)
        }.store(in: &headLinesSubsription)
        
        viewModel.$generalArticles.sink { (articles) in
            self.applySnapshot(articles: articles)
        }.store(in: &generalSubsription)
        
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Indo News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.register(HighlightCell.self, forCellWithReuseIdentifier: HighlightCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        configureDataSource()
    }
    
    private func applySnapshot(articles: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.topHeadline, .general])
        snapshot.appendItems(articles, toSection: .topHeadline)
        snapshot.appendItems(viewModel.generalArticles, toSection: .general)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexpath, article) -> UICollectionViewCell? in
            switch indexpath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightCell.reuseIdentifier, for: indexpath) as! HighlightCell
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
            default:
                sectionHeader.title.text = Section.general.string
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
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(250)), subitems: [layoutItem])
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
                
                layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
                
                return layoutSection
            default:
                return nil
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
        print("Tap")
    }
    
}
