//
//  MasterSplitViewController.swift
//  CloudNotes
//
//  Created by Ryan-Son on 2021/06/02.
//

import UIKit

final class MasterSplitViewController: UISplitViewController {

    override init(style: UISplitViewController.Style) {
        super.init(style: style)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        preferredDisplayMode = .oneBesideSecondary
        preferredSplitBehavior = .tile
        super.delegate = self
    }
}

extension MasterSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
    
    func splitViewControllerDidCollapse(_ svc: UISplitViewController) {
        print("splitViewControllerDidCollapse")
    }
}
