//
//  NoteListViewControllerActionsDelegate.swift
//  CloudNotes
//
//  Created by Ryan-Son on 2021/06/11.
//

import UIKit

protocol NoteListViewControllerActionsDelegate: AnyObject {
    func deleteTapped(at indexPath: IndexPath)
    func activityViewTapped(at indexPath: IndexPath)
}