//
//  CustomSegmentedControl.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/9/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

protocol ActivityDelegate: class {
	func scrollTo(index: Int)
}

class CustomSegmentedControl: UIView {

    var buttons = [UIButton]()
	var selector: UIView!
	var selectedSegmentIndex = 0
	
	let buttonTitles: [String] = ["Following", "You"]
	let textColor: UIColor = .black
	let selectorColor: UIColor = .black
	
	weak var delegate: ActivityDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		updateView()
	}
	
	func updateView() {
		
		buttons.removeAll()
		
		subviews.forEach { (view) in
			view.removeFromSuperview()
		}
		
		for buttonTitle in buttonTitles {
			let button = UIButton(type: .system)
			
			button.setTitle(buttonTitle, for: .normal)
			button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
			button.setTitleColor(textColor, for: .normal)
			buttons.append(button)
		}
		
		buttons[0].setTitleColor(selectorColor, for: .normal)
		
		let selectorWidth = frame.width / CGFloat(buttonTitles.count)
		let yPos = (self.frame.maxY - self.frame.minY) - 2.0
		
		selector = UIView(frame: CGRect.init(x: 0, y: yPos, width: selectorWidth, height: 2))
		selector.backgroundColor = selectorColor
		
		addSubview(selector)
		
		let stackView = UIStackView(arrangedSubviews: buttons)
		
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = 0
		
		addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		// Set Constraints
		stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
	}
	
	@objc private func buttonTapped(button: UIButton) {
		for (btnIndex, btn) in buttons.enumerated() {
			button.setTitleColor(textColor, for: .normal)
			
			if btn == button {
				selectedSegmentIndex = btnIndex
				delegate?.scrollTo(index: selectedSegmentIndex)
			}
		}
	}
	
	func updateSegmentedControlSegments(index: Int) {
		for btn in buttons {
			btn.setTitleColor(textColor, for: .normal)
		}
		
		let selectorStartPos = frame.width / CGFloat(buttons.count) * CGFloat(index)
		
		UIView.animate(withDuration: 0.3) {
			self.selector.frame.origin.x = selectorStartPos
		}
		
		buttons[index].setTitleColor(textColor, for: .normal)
	}

}
