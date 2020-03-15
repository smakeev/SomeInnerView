//
//  ViewController.swift
//  Example
//
//  Created by Sergey Makeev on 14.03.2020.
//  Copyright © 2020 SOME projects. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var innerView: InnerView!

	@IBOutlet weak var fixItem: UIBarButtonItem!
	@IBOutlet weak var editItem: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		innerView = InnerView()
		innerView.backgroundColor = .black
		innerView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(innerView)
		innerView.leadingAnchor.constraint (equalTo: self.view.leadingAnchor).isActive  = true
		innerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		innerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive           = true
		innerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive     = true
		
		guard let sourceImage = UIImage(named: "image") else { return }
	

		innerView.mainImage = sourceImage
		innerView.background.backgroundColor = .red
		
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		innerView.background.addSubview(blurEffectView)
		
		blurEffectView.leadingAnchor.constraint(equalTo: innerView.background.leadingAnchor).isActive = true
		blurEffectView.trailingAnchor.constraint(equalTo: innerView.background.trailingAnchor).isActive = true
		blurEffectView.topAnchor.constraint(equalTo: innerView.background.topAnchor).isActive = true
		blurEffectView.bottomAnchor.constraint(equalTo: innerView.background.bottomAnchor).isActive = true
		
		
		innerView.selectionView.backgroundColor = .white
		innerView.secondaryImage = sourceImage
	
		innerView.x = 0.25
		innerView.y = 0.25
		innerView.bottom = 0.7
		innerView.right  = 0.7
		innerView.isSelectionInitialized = true
		
		innerView.selectionView.layer.cornerRadius = 45
		innerView.selectionView.layer.masksToBounds = true
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		innerView.isSelectionFixed = false
	}
	
	@IBAction func doEdit() {
		editItem.title = innerView.selectionView.isUserInteractionEnabled ? "Edit" : "Done"
		innerView.selectionView.isUserInteractionEnabled.toggle()
		
		if innerView.selectionView.isUserInteractionEnabled {
			innerView.selectionView.layer.borderColor = UIColor.white.cgColor
			innerView.selectionView.layer.borderWidth = 2.0
		} else {
			innerView.selectionView.layer.borderWidth = 0
		}
	}
	
	@IBAction func fixSelection() {
		fixItem.title = innerView.isSelectionFixed ? "select" : "unselect"
		innerView.isSelectionFixed.toggle()
	}

}

