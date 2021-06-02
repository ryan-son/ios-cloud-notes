//
//  CloudNotes - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class NotesListViewController: UIViewController {
    var notes: [Note] = []
    
    
    enum Section {
        case main
    }
    
    var notesCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        configureNavigationBar()
        configureHierarchy()
        
        let noteCellNib = UINib(nibName: NoteCollectionViewListCell.reuseIdentifier, bundle: .main)
        notesCollectionView.register(noteCellNib, forCellWithReuseIdentifier: NoteCollectionViewListCell.reuseIdentifier)
        
        configureDataSource()
        

    }

}

extension NotesListViewController {
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

extension NotesListViewController {
    func configureHierarchy() {
        notesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        notesCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(notesCollectionView)
        notesCollectionView.delegate = self
    }
    
    func configureDataSource() {
//        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Note> { cell, indexPath, note in
//            var content = cell.defaultContentConfiguration()
//            
//            content.text = note.title
//            content.secondaryText = note.body
//            
//            cell.contentConfiguration = content
//            cell.accessories = [.disclosureIndicator()]
//        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Note>(collectionView: notesCollectionView) { collectionView, indexPath, note in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewListCell.reuseIdentifier, for: indexPath) as? NoteCollectionViewListCell
            
            cell?.configure(with: note)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        guard let data = NSDataAsset(name: "sample")?.data else {
        print("파일 못찾음")
            return }
        let jsonDecoder = JSONDecoder()
        
        do {
            notes = try jsonDecoder.decode([Note].self, from: data)
            snapshot.appendItems(notes)
            dataSource.apply(snapshot, animatingDifferences: false)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension NotesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let noteDetailViewController = splitViewController?.viewController(for: .secondary) as? NoteDetailViewController else {
            return
        }
        
        noteDetailViewController.note = notes[indexPath.item]
        noteDetailViewController.updateUI()
        noteDetailViewController.contentTextView.resignFirstResponder()
        
        splitViewController?.showDetailViewController(noteDetailViewController, sender: nil)
    }
}

extension NotesListViewController {
    func configureNavigationBar() {
        navigationItem.title = "메모"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        var snapshot = dataSource.snapshot()
        let itemToInsert = Note(title: "새 메모", body: "", lastModified: Int(Date().timeIntervalSince1970))
        snapshot.insertItems([itemToInsert], beforeItem: snapshot.itemIdentifiers.first!)
        notes.insert(itemToInsert, at: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
