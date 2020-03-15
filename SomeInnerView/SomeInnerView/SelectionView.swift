//
//  SelectionView.swift
//  SomeInnerView
//
//  Created by Sergey Makeev on 15.03.2020.
//  Copyright © 2020 SOME projects. All rights reserved.
//

import Foundation
import UIKit

class SelectionView: UIView {
	override  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isUserInteractionEnabled {
			super.touchesBegan(touches, with: event)
		} else {
			self.next?.touchesBegan(touches, with: event)
		}
	}
}

