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

}

