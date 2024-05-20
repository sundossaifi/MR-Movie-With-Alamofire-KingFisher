//
//  SplitViewController.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.preferredPrimaryColumnWidthFraction = 0.5
        self.minimumPrimaryColumnWidth = 250
        self.maximumPrimaryColumnWidth = 450
        self.preferredDisplayMode = .oneBesideSecondary
        self.delegate = self
    }
    
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
