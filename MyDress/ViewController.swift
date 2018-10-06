//
//  ViewController.swift
//  MyDress
//
//  Created by Ben Gray on 04/10/2018.
//  Copyright © 2018 crisogray. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet weak var scrollView: UIScrollView!
	var views = [ItemCard]()
	var imagePicker: UIImagePickerController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for i in 0...15 {
			let nib = Bundle.main.loadNibNamed("ItemCard", owner: nil, options: nil)![0] as! ItemCard
			nib.frame = CGRect(x: CGFloat(i) * w + w * 0.125, y: 0, width: w * 0.75, height: scrollView.frame.height * 0.9)
			views.append(nib)
			scrollView.addSubview(nib)
		}
		scrollView.contentSize.width = w * CGFloat(views.count)
	}
	
	@IBAction func takePicture() {
		imagePicker =  UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .camera
		imagePicker.allowsEditing = true
		present(imagePicker, animated: true, completion: nil)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let x = scrollView.contentOffset.x / w
		for (i, view) in views.enumerated() {
			let absDiff = min(abs(x - CGFloat(i)), 1), diff = absDiff * (2  - absDiff)
			view.transform = CGAffineTransform.identity.scaledBy(x: 1 - (0.25 * diff), y: 1 - (0.25 * diff))
		}
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		imagePicker.dismiss(animated: true, completion: nil)
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			
		}
	}

}

class ItemCard: UIView {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		imageView.layer.cornerRadius = 4
		layer.cornerRadius = 8
		layer.shadowColor = UIColor.black.cgColor
		layer.masksToBounds = false
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 8
		layer.shadowPath = UIBezierPath(rect: CGRect(origin: .zero, size: frame.size)).cgPath
		layer.shadowOpacity = 0.2
		layer.shouldRasterize = true
		layer.rasterizationScale = UIScreen.main.scale
	}
	
}
