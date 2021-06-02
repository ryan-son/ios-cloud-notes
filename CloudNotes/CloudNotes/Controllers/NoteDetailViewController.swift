//
//  CloudNotes - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class NoteDetailViewController: UIViewController {
    
    var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTextView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contentTextView.endEditing(true)
    }
    
    func configureTextView() {
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func updateUI() {
        guard let note = note else {
            contentTextView.text = "첫 페이지입니다"
            return
        }
        
        contentTextView.text = ""
        contentTextView.insertText(note.title + "\n")
        contentTextView.insertText(note.body)
    }
    
    
}

extension NoteDetailViewController {
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(elipsisTapped))
    }
    
    @objc func elipsisTapped() { }
}
