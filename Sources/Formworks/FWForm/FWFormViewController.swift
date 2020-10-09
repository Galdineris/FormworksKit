//
//  FWFormController.swift
//  
//
//  Created by Artur Carneiro on 29/09/20.
//

import UIKit

/// Representation of a form. It displays each component as a cell of a `UICollectionView`.
public final class FWFormViewController: UIViewController {
    // - MARK: Properties
    /// The form containing components as cells.
    private lazy var formCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setUpCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FWFormViewControllerCell.self,
                                forCellWithReuseIdentifier: FWFormViewControllerCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .fwFormBackground
        return collectionView
    }()

    //- MARK: Init
    /// Initializes a new instance of this type.
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    public override func loadView() {
        super.loadView()
        view.backgroundColor = .fwFormBackground
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViewConstraints()
    }

    /**
    This function will set up the layout of the CollectionView. It first configure
    the item size that will be present on a group. And then configure
    the group size so it specifies the portion of the screen that will occupy
     */
    @available(iOS 13.0, *)
    private func setUpCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(FormSpec.itemFractionalWidth),
                                                    heightDimension: .fractionalHeight(FormSpec.itemFractionalHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(FormSpec.groupFractionalWidth),
                                                     heightDimension: .fractionalHeight(FormSpec.groupFractionalHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: FormSpec.groupSpacingTop,
                                                      leading: FormSpec.groupSpacingLeading,
                                                      bottom: FormSpec.groupSpacingBottom,
                                                      trailing: FormSpec.groupSpacingTrailing)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    /// This function will create the necessary constraints for the CollectionView
    /// to occupy the entire ViewController.
    private func setUpCollectionViewConstraints() {
        view.addSubview(formCollectionView)
        let guides = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            formCollectionView.topAnchor.constraint(equalTo: guides.topAnchor),
            formCollectionView.leftAnchor.constraint(equalTo: guides.leftAnchor),
            formCollectionView.bottomAnchor.constraint(equalTo: guides.bottomAnchor),
            formCollectionView.rightAnchor.constraint(equalTo: guides.rightAnchor)
        ])
    }
}
//- MARK: UICollectionViewDelegate
extension FWFormViewController: UICollectionViewDelegate {
    
}
//- MARL: UICollectionViewDataSource
extension FWFormViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FWFormViewControllerCell.identifier,
                                                            for: indexPath) as? FWFormViewControllerCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}