//
//  InnerView.swift
//  SomeInnerView
//
//  Created by Sergey Makeev on 14.03.2020.
//  Copyright © 2020 SOME projects. All rights reserved.
//

import Foundation
import UIKit

public class InnerView: UIView {
	
	public var mainImage:      UIImage? {
		didSet {
			update()
		}
	}
	public var secondaryImage: UIImage? {
		didSet {
			updateSecondary()
		}
	}
	
	public var background: UIView {
		get {
			mainView!
		}
	}
	
	public var selectionView: UIView {
		get {
			rectangleView
		}
	}
	
	public var isSelectionFixed: Bool = true
	public var isSelectionInitialized: Bool = false {
		didSet {
			if !isSelectionInitialized {
				rectangleView.isHidden = true
			} else {
				rectangleView.isHidden = false
			}
		}
	}
	
	public private(set) var rectangleView: UIView!
	public private(set) var position: CGRect = .zero // all values form 0 upto 1

	fileprivate var mainView:  UIImageView!
	private var secondaryView: UIImageView!

	public var maximumAllowedExtraZoom: CGFloat = 4 //does not change zoom on change
	public var extraZoom: Bool = true {
		didSet {
			update()
			if scrollView.zoomScale < minScale { //Adjust current scale if it is not applicable in new sizes
				scrollView.zoomScale = minScale
			} else if scrollView.zoomScale > maxScale {
				scrollView.zoomScale = maxScale
			}
		}
	}

	private var _x:      CGFloat = 0
	private var _y:      CGFloat = 0
	private var _right:  CGFloat = 0
	private var _bottom: CGFloat = 0

	public var x:      CGFloat {
		set {
			_x = newValue
			updateSecondary()
		}
		
		get { _x }
	}
	public var y:      CGFloat {
		set {
			_y = newValue
			updateSecondary()
		}
		
		get { _y }
	}
	public var right:  CGFloat {
		set {
			_right = newValue
			updateSecondary()
		}
		
		get { _right }
	}
	public var bottom: CGFloat {
		set {
			_bottom = newValue
			updateSecondary()
		}
		
		get { _bottom }
	}
	
	private var scrollView: UIScrollView!
	private var initialized: Bool = false
	
    var minScale:  CGFloat = 0
    var maxScale:  CGFloat = 0
    
    private var leftMargin: CGFloat = 0
    private var topMargin:  CGFloat = 0
    
    fileprivate var doubleTapRecognizer:     UITapGestureRecognizer!
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		internalInit()
	}
	
	public init() {
		super.init(frame: .zero)
		internalInit()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		internalInit()
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		if !scrollView.isZooming {
			update()
		}
	}
	
	private func internalInit() {
		scrollView    = UIScrollView()
		mainView      = UIImageView()
		secondaryView = UIImageView()
		rectangleView = UIView()
		rectangleView.isHidden = true
		rectangleView.isUserInteractionEnabled = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		mainView.translatesAutoresizingMaskIntoConstraints   = false
		
		self.addSubview(scrollView)
		scrollView.addSubview(mainView)
		
		scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive   = true
		scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive     = true
		scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive           = true
		
		scrollView.delegate = self
		
		scrollView.showsVerticalScrollIndicator   = false
		scrollView.showsHorizontalScrollIndicator = false
		
		scrollView.bounces     = false
		scrollView.bouncesZoom = false
		
		self.addSubview(rectangleView)
		self.bringSubviewToFront(rectangleView)
		
		rectangleView.addSubview(secondaryView)
		secondaryView.clipsToBounds = true
		rectangleView.clipsToBounds = true
		
		mainView.isUserInteractionEnabled = true
		doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTappingHandler(_:)))
		doubleTapRecognizer.numberOfTapsRequired = 2
		mainView.addGestureRecognizer(doubleTapRecognizer)
	}

	@objc
	private func onDoubleTappingHandler(_ sender: UITapGestureRecognizer) {
		if scrollView.zoomScale == minScale {
			scrollView.setZoomScale(maxScale, animated: true)
		} else {
			scrollView.setZoomScale(minScale, animated: true)
		}
		
	}

	fileprivate func centerScrollViewContent() {
        leftMargin  = CGFloat(scrollView.frame.size.width  - mainView.frame.size.width ) * 0.5
        topMargin   = CGFloat(scrollView.frame.size.height - mainView.frame.size.height) * 0.5
        scrollView.contentInset = UIEdgeInsets(top: CGFloat(fmaxf(0, Float(topMargin))), left: CGFloat(fmaxf(0, Float(leftMargin))), bottom: 0, right: 0)
    }

	
	//size in percents
	public func changeSecondaryViewSize(to size: CGSize) {
		
	}
	
	private func update() {
		guard let validImage = mainImage else { return }
		mainView.image = mainImage
		let zoomBefore = scrollView.zoomScale
		scrollView.zoomScale  = 1.0
		scrollView.contentSize = validImage.size
		mainView.frame =  CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: validImage.size.width, height: validImage.size.height))
		
		scrollView.zoomScale  = zoomBefore
		
		let scrollViewSize = scrollView.bounds.size

		let widthScale  = scrollViewSize.width  / validImage.size.width
		let heightScale = scrollViewSize.height / validImage.size.height

		minScale                    = fmin(widthScale, heightScale)
		maxScale                    = fmax(widthScale, heightScale)
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = extraZoom ? maximumAllowedExtraZoom : maxScale
		
		if !initialized && maxScale != 0 {
			initialized = true
			scrollView.setZoomScale(maxScale, animated: true)
		} else if scrollView.zoomScale > scrollView.maximumZoomScale {
			scrollView.setZoomScale(maxScale, animated: false)
		} else if scrollView.zoomScale < minScale {
			scrollView.setZoomScale(minScale, animated: false)
		}
		
		centerScrollViewContent()
		updateSecondary()
	}
	
	private func updateSecondary() {
		func internalCalculations() {
			guard let mainImage = mainImage,
				let secondaryImage = secondaryImage else { return }
			
			let selectionWidth  = ((right  - x) * mainImage.size.width) * scrollView.zoomScale
			let selectionHeight = ((bottom - y) * mainImage.size.height) * scrollView.zoomScale
			let xPos = (mainImage.size.width * x) * scrollView.zoomScale - scrollView.contentOffset.x
			let yPos = (mainImage.size.height * y) * scrollView.zoomScale - scrollView.contentOffset.y
			
			selectionView.frame = CGRect(x: xPos, y: yPos, width: selectionWidth, height: selectionHeight)
			
			
			secondaryView.frame = CGRect(x: -xPos - scrollView.contentOffset.x, y: -yPos  - scrollView.contentOffset.y, width: secondaryImage.size.width * scrollView.zoomScale, height: secondaryImage.size.height * scrollView.zoomScale)
		}
		
		guard let mainImage = mainImage,
			let secondaryImage = secondaryImage else { return }
		
		secondaryView.image = secondaryImage
		
		if isSelectionFixed || !isSelectionInitialized {
			internalCalculations()
		} else if !isSelectionFixed && isSelectionInitialized {
			let currentXInFrame = selectionView.frame.origin.x
			let currentYInFrame = selectionView.frame.origin.y
			let currentWidthInFrame = selectionView.frame.size.width
			let currentHeightInFrame = selectionView.frame.size.height
			
			_x = (currentXInFrame + scrollView.contentOffset.x) / (mainImage.size.width * scrollView.zoomScale)
			_y = (currentYInFrame + scrollView.contentOffset.y) / (mainImage.size.height * scrollView.zoomScale)
			
			_right  = currentWidthInFrame / (mainImage.size.width * scrollView.zoomScale) + x
			_bottom = currentHeightInFrame / (mainImage.size.height * scrollView.zoomScale) + y
			
			internalCalculations()
		}
	}
}

extension InnerView: UIScrollViewDelegate {
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return mainView
	}
	
	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		centerScrollViewContent()
		updateSecondary()
	 }
	 
	 public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard !scrollView.isZooming else { return }
		updateSecondary()
	}
}
