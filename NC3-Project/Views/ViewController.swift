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
    var snapshot: NSDiffableDataSourceSnapshot<Section, Article>!
    var collectionView: UICollectionView!
    
    var viewModel = ArticleViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Indo News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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

        viewModel.$technologyToken.sink { (articles) in
            self.viewModel.technology = articles
            self.applySnapshot()
        }.store(in: &cancellables)

        viewModel.$healthToken.sink { (articles) in
            self.viewModel.health = articles
            self.applySnapshot()
        }.store(in: &cancellables)

        viewModel.$scienceToken.sink { (articles) in
            self.viewModel.science = articles
            self.applySnapshot()
        }.store(in: &cancellables)
        
        viewModel.$sportsToken.sink { (articles) in
            self.viewModel.sports = articles
            self.applySnapshot()
        }.store(in: &cancellables)
        
        viewModel.$entertainmentToken.sink { (articles) in
            self.viewModel.entertainment = articles
            print(self.viewModel.entertainment.count)
            self.applySnapshot()
        }.store(in: &cancellables)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.register(LargeCell.self, forCellWithReuseIdentifier: LargeCell.reuseIdentifier)
        collectionView.register(SmallCell.self, forCellWithReuseIdentifier: SmallCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        configureDataSource()
    }
    
    private func applySnapshot() {
        
        snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        
        snapshot?.appendSections([.topHeadline, .business, .technology, .health, .science, .sports, .entertainment])
    
        snapshot?.appendItems(viewModel.headline, toSection: .topHeadline)
        snapshot?.appendItems(viewModel.business, toSection: .business)
        snapshot?.appendItems(viewModel.technology, toSection: .technology)
        snapshot?.appendItems(viewModel.health, toSection: .health)
        snapshot?.appendItems(viewModel.science, toSection: .science)
        snapshot?.appendItems(viewModel.sports, toSection: .sports)
        snapshot?.appendItems(viewModel.entertainment, toSection: .entertainment)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexpath, article) -> UICollectionViewCell? in
            switch indexpath.section {
            case 0:
                return configureCell(LargeCell.self, with: article, for: indexpath)
            case 1:
                return configureCell(LargeCell.self, with: article, for: indexpath)
            case 2:
                return configureCell(SmallCell.self, with: article, for: indexpath)
            case 3:
                return configureCell(LargeCell.self, with: article, for: indexpath)
            case 4:
                return configureCell(SmallCell.self, with: article, for: indexpath)
            case 5:
                return configureCell(LargeCell.self, with: article, for: indexpath)
            case 6:
                return configureCell(SmallCell.self, with: article, for: indexpath)
            default:
                return nil
            }
        })
        
        func configureCell<T: ConfigureCellProtocol>(_ cellType: T.Type, with article: Article, for indexPath: IndexPath) -> T {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to deque \(cellType)") }
            cell.configure(article: article)
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
            
            switch indexPath.section {
            case 0:
                sectionHeader.title.text = Section.topHeadline.string
            case 1:
                sectionHeader.title.text = Section.business.string
            case 2:
                sectionHeader.title.text = Section.technology.string
            case 3:
                sectionHeader.title.text = Section.health.string
            case 4:
                sectionHeader.title.text = Section.science.string
            case 5:
                sectionHeader.title.text = Section.sports.string
            case 6:
                sectionHeader.title.text = Section.entertainment.string
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
                return self.createLargeCell()
            case 1:
                return self.createMediumCell()
            case 3:
                return self.createLargeCell()
            case 5:
                return self.createMediumCell()
            default:
                return self.createGroupCell()
            }
        }
    }
        
    private func createLargeCell() -> NSCollectionLayoutSection {
        let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(300)), subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
        layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
        
        return layoutSection
    }
    
    private func createMediumCell() -> NSCollectionLayoutSection {
        let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10)
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(200)), subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
        layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
        
        return layoutSection
    }
    
    private func createGroupCell() -> NSCollectionLayoutSection {
        let layoutItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33)))
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 10)
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.35)), subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16 , bottom: 16, trailing: 0)
        
        layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
        
        return layoutSection
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
            pushViewController(article: viewModel.headline[indexPath.row])
        case 1:
            pushViewController(article: viewModel.business[indexPath.row])
        case 2:
            pushViewController(article: viewModel.technology[indexPath.row])
        case 3:
            pushViewController(article: viewModel.health[indexPath.row])
        case 4:
            pushViewController(article: viewModel.science[indexPath.row])
        case 5:
            pushViewController(article: viewModel.sports[indexPath.row])
        case 6:
            pushViewController(article: viewModel.entertainment[indexPath.row])
        default:
            return 
        }
    }
    
    func pushViewController(article: Article) {
        let vc = DetailViewController()
        vc.article = article
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

